package io.dat.domain.user;

import com.chequer.axboot.core.parameter.RequestParams;
import com.querydsl.core.BooleanBuilder;
import io.dat.domain.BaseService;
import io.dat.domain.user.auth.UserAuth;
import io.dat.domain.user.auth.UserAuthService;
import io.dat.domain.user.role.UserRole;
import io.dat.domain.user.role.UserRoleService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import javax.transaction.Transactional;
import java.time.Clock;
import java.time.Instant;
import java.util.List;


@Service
public class UserService extends BaseService<User, String> {

    private UserRepository userRepository;

    @Inject
    private UserAuthService userAuthService;

    @Inject
    private UserRoleService userRoleService;

    @Inject
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @Inject
    public UserService(UserRepository userRepository) {
        super(userRepository);
        this.userRepository = userRepository;
    }

    @Transactional
    public void saveUser(List<User> users) {

        if (isNotEmpty(users)) {
            users.stream()
                 .map(user -> updateUserEntity(user))
                 .forEach(user -> {
                    try {
                        doSaveJob(user);
                    } catch (Exception e) {
                        throw new RuntimeException(e.getMessage());
                    }
                 });
        }
    }

    public User updateUserEntity(User user) {

        String password = bCryptPasswordEncoder.encode(user.getUserPs());
        User originalUser = userRepository.findOne(user.getUserCd());

        if (originalUser != null) {
            if (isNotEmpty(user.getUserPs())) {
                user.setPasswordUpdateDate(Instant.now(Clock.systemUTC()));
                user.setUserPs(password);
            } else {
                user.setUserPs(originalUser.getUserPs());
            }
        } else {
            user.setPasswordUpdateDate(Instant.now(Clock.systemUTC()));
            user.setUserPs(password);
        }

        return user;
    }

    private void doSaveJob(User user) throws Exception {

        delete(qUserRole).where(qUserRole.userCd.eq(user.getUserCd())).execute();
        delete(qUserAuth).where(qUserAuth.userCd.eq(user.getUserCd())).execute();

        save(user);

        doSaveUserAuthAndRole(user);
    }

    private void doSaveUserAuthAndRole(User user) throws Exception {

        for (UserAuth userAuth : user.getAuthList()) {
            userAuth.setUserCd(user.getUserCd());
        }

        for (UserRole userRole : user.getRoleList()) {
            userRole.setUserCd(user.getUserCd());
        }

        userAuthService.save(user.getAuthList());
        userRoleService.save(user.getRoleList());
    }

    /*@Transactional
    public void saveUser(List<User> users) throws Exception {
        if (isNotEmpty(users)) {
            for (User user : users) {
                delete(qUserRole).where(qUserRole.userCd.eq(user.getUserCd())).execute();
                delete(qUserAuth).where(qUserAuth.userCd.eq(user.getUserCd())).execute();

                String password = bCryptPasswordEncoder.encode(user.getUserPs());
                User originalUser = userRepository.findOne(user.getUserCd());

                if (originalUser != null) {
                    if (isNotEmpty(user.getUserPs())) {
                        user.setPasswordUpdateDate(Instant.now(Clock.systemUTC()));
                        user.setUserPs(password);
                    } else {
                        user.setUserPs(originalUser.getUserPs());
                    }
                } else {
                    user.setPasswordUpdateDate(Instant.now(Clock.systemUTC()));
                    user.setUserPs(password);
                }

                save(user);

                for (UserAuth userAuth : user.getAuthList()) {
                    userAuth.setUserCd(user.getUserCd());
                }

                for (UserRole userRole : user.getRoleList()) {
                    userRole.setUserCd(user.getUserCd());
                }

                userAuthService.save(user.getAuthList());
                userRoleService.save(user.getRoleList());
            }
        }
    }*/

    public User getUser(RequestParams requestParams) {
        User user = get(requestParams).stream().findAny().orElse(null);

        if (user != null) {
            user.setAuthList(userAuthService.get(requestParams));
            user.setRoleList(userRoleService.get(requestParams));
        }

        return user;
    }

    public List<User> get(RequestParams requestParams) {
        String userCd = requestParams.getString("userCd");
        String filter = requestParams.getString("filter");

        BooleanBuilder builder = new BooleanBuilder();

        if (isNotEmpty(userCd)) {
            builder.and(qUser.userCd.eq(userCd));
        }

        List<User> list = select().from(qUser).where(builder).orderBy(qUser.userNm.asc()).fetch();

        if (isNotEmpty(filter)) {
            list = filter(list, filter);
        }

        return list;
    }
}
