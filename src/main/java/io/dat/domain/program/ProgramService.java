package io.dat.domain.program;

import com.chequer.axboot.core.parameter.RequestParams;
import com.chequer.axboot.core.utils.TemplateUtils;
import com.querydsl.core.BooleanBuilder;
import io.dat.domain.BaseService;
import io.dat.domain.user.auth.menu.AuthGroupMenu;
import io.dat.domain.user.auth.menu.AuthGroupMenuService;
import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class ProgramService extends BaseService<Program, String> {

    private ProgramRepository programRepository;

    @Inject
    private AuthGroupMenuService authGroupMenuService;

    @Inject
    public ProgramService(ProgramRepository programRepository) {
        super(programRepository);
        this.programRepository = programRepository;
    }

    public List<Program> get(RequestParams<Program> requestParams) {
        String filter = requestParams.getFilter();

        BooleanBuilder builder = new BooleanBuilder();

        List list = select().from(qProgram).where(builder).orderBy(qProgram.progNm.asc()).fetch();

        if (isNotEmpty(filter)) {
            list = filter(list, filter);
        }

        return list;
    }

    private void processDeleteJob(Program program) {

        List<Long> menuIds =
                select().select(qMenu.menuId).distinct()
                        .from(qMenu)
                        .where(qMenu.progCd.eq(program.getProgCd()))
                        .fetch();

        delete(qAuthGroupMenu)
                .where(qAuthGroupMenu.menuId.in(menuIds))
                .execute();

        update(qMenu)
                .setNull(qMenu.progCd)
                .where(qMenu.progCd.eq(program.getProgCd()))
                .execute();

        delete(program.getId());
    }

    private Program processInsertJob(Program program) {
        program.setProgCd(FilenameUtils.getBaseName(program.getProgPh()));
        return program;
    }

    private Program processUpdateJob(Program program) {

        List<Long> menuIds =
                select().select(qMenu.menuId).distinct()
                        .from(qMenu)
                        .where(qMenu.progCd.eq(program.getProgCd()))
                        .fetch();

        List<AuthGroupMenu> authGroupMenuList =
                select().select(qAuthGroupMenu)
                        .from(qAuthGroupMenu)
                        .where(qAuthGroupMenu.menuId.in(menuIds))
                        .fetch();

        // 해당 프로그램으로 권한 그룹이 등록된 경우 권한을 다시 설정 (Y -> N로 변경된 항목만 체크)
        if (isNotEmpty(authGroupMenuList)) {
            for (AuthGroupMenu authGroupMenu : authGroupMenuList) {
                authGroupMenu.updateAuthorization(program);
                authGroupMenuService.save(authGroupMenu);
            }
        }

        Program existProgram = findOne(program.getId());

        // 프로그램 코드가 변경되었을 경우
        if (notEquals(existProgram.getProgPh(), program.getProgPh())) {

            program.setProgCd(FilenameUtils.getBaseName(program.getProgPh()));

            delete(existProgram.getId());

            // 메뉴에 메뉴코드 & 프로그램코드 변경
            update(qMenu)
                .set(qMenu.progCd, program.getProgCd())
                .where(qMenu.progCd.eq(existProgram.getProgCd()))
                .execute();
        }

        return program;
    }

    @Transactional
    public void saveProgram(List<Program> programs) {

        Map<Boolean, List<Program>> partitioned =
                programs.stream().collect(Collectors.partitioningBy(program -> program.isDeleted()));

        List<Program> deleteJobList = partitioned.get(Boolean.TRUE);

        // 삭제 처리
        deleteJobList.stream()
                     .forEach(program -> {
                         try {
                             processDeleteJob(program);
                         } catch (Exception e) {
                             throw new RuntimeException(e.getMessage());
                         }
                     });

        List<Program> saveJobList = partitioned.get(Boolean.FALSE);

        Map<Boolean, List<Program>> saveJobPartitioned =
                saveJobList.stream().collect(Collectors.partitioningBy(program -> isEmpty(program.getProgCd())));

        List<Program> insertJobList = saveJobPartitioned.get(Boolean.TRUE);
        List<Program> updateJobList = saveJobPartitioned.get(Boolean.FALSE);

        Stream<Program> insertJobStream = insertJobList.stream().map(this::processInsertJob);
        Stream<Program> updateJobStream = updateJobList.stream().map(this::processUpdateJob);

        //저장 처리
        Stream.concat(insertJobStream, updateJobStream)
              .forEach(program -> {
                  try {
                      TemplateUtils.makeJspAndJsFiles(program.getProgPh());
                      save(program);
                  } catch (Exception e) {
                      throw new RuntimeException(e.getMessage());
                  }
              });


        /*for (Program program : programs) {

            // 삭제 처리
            if (program.isDeleted()) {

                List<Long> menuIds = select().select(qMenu.menuId).distinct()
                                             .from(qMenu)
                                             .where(qMenu.progCd.eq(program.getProgCd()))
                                             .fetch();

                delete(qAuthGroupMenu)
                    .where(qAuthGroupMenu.menuId.in(menuIds))
                    .execute();

                update(qMenu)
                    .setNull(qMenu.progCd)
                    .where(qMenu.progCd.eq(program.getProgCd()))
                    .execute();

                delete(program.getId());
            }

            // 저장 처리
            else {
                TemplateUtils.makeJspAndJsFiles(program.getProgPh());

                // 신규 저장일 경우
                if (isEmpty(program.getProgCd())) {
                    program.setProgCd(FilenameUtils.getBaseName(program.getProgPh()));
                    save(program);

                } else {
                    // 신규 저장이 아닐 경우

                    List<Long> menuIds = select().select(qMenu.menuId).distinct().from(qMenu).where(qMenu.progCd.eq(program.getProgCd())).fetch();
                    List<AuthGroupMenu> authGroupMenuList = select().select(qAuthGroupMenu).from(qAuthGroupMenu).where(qAuthGroupMenu.menuId.in(menuIds)).fetch();

                    // 해당 프로그램으로 권한 그룹이 등록된 경우 권한을 다시 설정 (Y -> N로 변경된 항목만 체크)
                    if (isNotEmpty(authGroupMenuList)) {
                        for (AuthGroupMenu authGroupMenu : authGroupMenuList) {
                            authGroupMenu.updateAuthorization(program);
                            authGroupMenuService.save(authGroupMenu);
                        }
                    }

                    Program existProgram = findOne(program.getId());

                    // 프로그램 코드가 변경되었을 경우
                    if (notEquals(existProgram.getProgPh(), program.getProgPh())) {
                        program.setProgCd(FilenameUtils.getBaseName(program.getProgPh()));

                        delete(existProgram.getId());

                        // 메뉴에 메뉴코드 & 프로그램코드 변경
                        update(qMenu)
                                .set(qMenu.progCd, program.getProgCd())
                                .where(qMenu.progCd.eq(existProgram.getProgCd()))
                                .execute();

                    }
                    save(program);
                }
            }
        }*/
    }
}
