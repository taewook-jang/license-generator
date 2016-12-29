package io.dat.controllers.axboot;

import com.chequer.axboot.core.utils.SessionUtils;
import io.dat.domain.init.DatabaseInitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.PostConstruct;

/**
 * Created by tw.jang on 2016-12-28.
 */
@Controller
public class LoginController {

    @Autowired
    private DatabaseInitService databaseInitService;

    private boolean initialized;

    @PostConstruct
    private void checkDbInitJob() {
        initialized = databaseInitService.initialized();
    }

    @GetMapping("/login")
    public String login() {

        String nextPage = "/login";

        if (!initialized) {
            nextPage = "redirect:/setup";
        }

        if (SessionUtils.isLoggedIn()) {
            nextPage = "/main";
        }

        return nextPage;
    }
}
