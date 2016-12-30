package io.dat.controllers.axboot;

import com.chequer.axboot.core.utils.SessionUtils;
import io.dat.domain.init.DatabaseInitService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.PostConstruct;

/**
 * Created by tw.jang on 2016-12-28.
 */
@Slf4j
@Controller
public class LoginController {

    @Autowired
    private DatabaseInitService databaseInitService;

    private boolean initialized;

    @Value("${axboot.app.name}")
    private String appName;

    @PostConstruct
    private void checkDbInitJob() {
        initialized = databaseInitService.initialized();
    }

    @GetMapping({"/", "/login"})
    public String login() {

        String nextPage = "/login";

        if (!initialized) {
            nextPage = "redirect:/setup";
        }

        if (SessionUtils.isLoggedIn()) {
            nextPage = "redirect:/" + appName;
        }

        return nextPage;
    }
}
