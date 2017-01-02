package com.chequer.axboot.core.db.schema;

import com.chequer.axboot.core.config.AXBootContextConfig;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.BootstrapServiceRegistry;
import org.hibernate.boot.registry.BootstrapServiceRegistryBuilder;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.internal.SessionFactoryImpl;
import org.hibernate.metadata.ClassMetadata;
import org.reflections.Reflections;
import org.reflections.util.ClasspathHelper;
import org.reflections.util.ConfigurationBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;

import javax.persistence.Entity;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

public class SchemaGeneratorBase {

    @Autowired
    protected EntityManagerFactory entityManagerFactory;

    @Autowired
    protected EntityManager entityManager;

    @Autowired
    protected LocalContainerEntityManagerFactoryBean localContainerEntityManagerFactoryBean;

    @Autowired
    protected JdbcTemplate jdbcTemplate;

    @Autowired
    protected Environment environment;

    @Autowired
    private AXBootContextConfig axBootContextConfig;

    protected SessionFactoryImpl getSessionFactory() {
        Session session = (Session) entityManager.getDelegate();
        return (SessionFactoryImpl) session.getSessionFactory();
    }

    protected Metadata getMetaData() {
        Properties prop = new Properties();
        prop.put("hibernate.dialect", getSessionFactory().getJdbcServices().getDialect().toString());
        prop.put("hibernate.hbm2ddl.auto", "create");
        prop.put("hibernate.show_sql", "true");
        prop.put("hibernate.connection.username", environment.getProperty("axboot.dataSource.username", ""));
        prop.put("hibernate.connection.password", environment.getProperty("axboot.dataSource.password", ""));
        prop.put("hibernate.connection.url", environment.getProperty("axboot.dataSource.url", ""));

        BootstrapServiceRegistry bsr = new BootstrapServiceRegistryBuilder().build();
        StandardServiceRegistryBuilder ssrBuilder = new StandardServiceRegistryBuilder(bsr);
        ssrBuilder.applySettings(prop);
        StandardServiceRegistry standardServiceRegistry = ssrBuilder.build();

        MetadataSources metadataSources = new MetadataSources(standardServiceRegistry);

        Reflections reflections = new Reflections(axBootContextConfig.getBasePackageName());

        reflections.getTypesAnnotatedWith(Entity.class)
                .forEach(metadataSources::addAnnotatedClass);

        return metadataSources.buildMetadata();
    }

    public List<String> getTableList() {
        List<String> tableName = new ArrayList();

        new Reflections()
                .getTypesAnnotatedWith(Entity.class)
                .forEach(clazz -> {
                    if (clazz.isAnnotationPresent(Table.class)) {
                        tableName.add(clazz.getAnnotation(Table.class).name());
                    }
                });

        return tableName;
    }

    protected String getEntityClassName(String tableName) {
        SessionFactory sessionFactory = entityManagerFactory.unwrap(SessionFactory.class);
        //Set<EntityType<?>> entities = sessionFactory.getMetamodel().getEntities();

        Map<String, ClassMetadata> classMetadataMap = sessionFactory.getAllClassMetadata();

        for (String key : classMetadataMap.keySet()) {
            try {
                Class<?> entityClass = Class.forName(key);

                if (entityClass.isAnnotationPresent(Table.class)) {
                    String entityTableName = entityClass.getAnnotation(Table.class).name();
                    if (entityTableName.toLowerCase().equals(tableName.toLowerCase())) {
                        return entityClass.getName();
                    }
                } else {
                    if (entityClass.getName().equals(tableName)) {
                        return entityClass.getName();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        /*
        for (EntityType<?> entityType : entities) {
            Class<?> entityClass = entityType.getJavaType();

            if (entityClass.isAnnotationPresent(Table.class)) {
                String entityTableName = entityClass.getAnnotation(Table.class).name();
                if (entityTableName.toLowerCase().equals(tableName.toLowerCase())) {
                    return entityClass.getName();
                }
            } else {
                if (entityClass.getName().equals(tableName)) {
                    return entityClass.getName();
                }
            }
        }
        */
        return null;
    }
}
