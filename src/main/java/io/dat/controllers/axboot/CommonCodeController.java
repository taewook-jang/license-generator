package io.dat.controllers.axboot;

import com.chequer.axboot.core.api.response.ApiResponse;
import com.chequer.axboot.core.api.response.Responses;
import com.chequer.axboot.core.controllers.BaseController;
import com.wordnik.swagger.annotations.ApiImplicitParam;
import com.wordnik.swagger.annotations.ApiImplicitParams;
import io.dat.domain.code.CommonCode;
import io.dat.domain.code.CommonCodeService;
import io.dat.domain.code.CommonCodeVO;
import io.dat.utils.CommonCodeUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/commonCodes")
public class CommonCodeController extends BaseController {

    @Inject
    private CommonCodeService basicCodeService;

    @ApiImplicitParams({
        @ApiImplicitParam(name = "groupCd", dataType = "String", paramType = "query", value = "분류 코드"),
        @ApiImplicitParam(name = "useYn",   dataType = "String", paramType = "query", value = "사용여부 (Y/N)"),
        @ApiImplicitParam(name = "filter",  dataType = "String", paramType = "query", value = "검색어")
    })
    @GetMapping
    public Responses.PageResponse list(Pageable pageable) {
        Page<CommonCode> pages = basicCodeService.findAll(pageable);
        return Responses.PageResponse.of(CommonCodeVO.of(pages.getContent()), pages);
    }

    @PutMapping
    public ApiResponse save(@Valid @NotNull @RequestBody List<CommonCode> basicCodes) {
        basicCodeService.saveCommonCode(basicCodes);
        return ok();
    }

    @GetMapping("/getAllByMap")
    public Map<String, List<CommonCode>> getAllByMap() {
        return CommonCodeUtils.getAllByMap();
    }
}

/*    public Responses.ListResponse list(RequestParams<CommonCode> requestParams) {
        List<CommonCode> basicCodes = basicCodeService.get(requestParams);
        return Responses.ListResponse.of(basicCodes);
    }*/