package io.dat.controllers.axboot;

import com.chequer.axboot.core.api.response.ApiResponse;
import com.chequer.axboot.core.api.response.Responses;
import com.chequer.axboot.core.controllers.BaseController;
import io.dat.domain.log.ErrorLog;
import io.dat.domain.log.ErrorLogService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;

@RestController
@RequestMapping("/api/v1/errorLogs")
public class ErrorLogViewController extends BaseController {

    @Inject
    private ErrorLogService errorLogService;

    @GetMapping
    public Responses.PageResponse list(Pageable pageable, @RequestParam(required = false) String searchParams) {
        Page<ErrorLog> errorLogPage = errorLogService.findAll(pageable, searchParams);
        return Responses.PageResponse.of(errorLogPage);
    }

    @DeleteMapping("/{id}")
    public ApiResponse delete(@PathVariable(value = "id") Long id) {
        errorLogService.delete(id);
        return ok();
    }

    @DeleteMapping("/events/all")
    public ApiResponse deleteAll() {
        errorLogService.deleteAllLogs();
        return ok();
    }
}
