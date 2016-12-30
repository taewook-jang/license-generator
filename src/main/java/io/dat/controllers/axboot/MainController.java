package io.dat.controllers.axboot;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Created by tw.jang on 2016-12-28.
 */
@Slf4j
@Controller
public class MainController {

    @GetMapping("/${axboot.app.name}")
    public String login() {
        return "/main";
    }
}

