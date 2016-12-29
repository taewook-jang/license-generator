package io.dat;

import com.chequer.axboot.core.AXBootCoreConfiguration;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.PropertySource;

@SpringBootApplication
@PropertySource(value = {"classpath:axboot-common.properties", "classpath:axboot-${spring.profiles.active:local}.properties"})
public class AppRunner extends SpringBootServletInitializer {

    public static final Object[] APPLICATION_SOURCES = new Object[] { AppRunner.class, AXBootCoreConfiguration.class };

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(APPLICATION_SOURCES);
    }

    public static void main(String[] args) {

        ConfigurableApplicationContext context = SpringApplication.run(APPLICATION_SOURCES, args);

        /*DatabaseInitService databaseInitService = context.getBean(DatabaseInitService.class);

        try {
            databaseInitService.createDefaultData();
        } catch (IOException e) {
            e.printStackTrace();
        }*/

    }
}
