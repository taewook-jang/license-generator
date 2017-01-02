package com.chequer.axboot.core.db.schema;

import com.chequer.axboot.core.annotations.ColumnPosition;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.boot.spi.MetadataImplementor;
import org.hibernate.tool.hbm2ddl.SchemaExport;
import org.springframework.boot.orm.jpa.hibernate.SpringNamingStrategy;
import org.springframework.stereotype.Component;

import javax.persistence.Column;
import javax.persistence.Transient;
import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.*;

import static java.util.stream.Collectors.toList;

@Component
public class SchemaGenerator extends SchemaGeneratorBase {

    public void createSchema() throws IOException, ClassNotFoundException {
        SchemaExport export = new SchemaExport((MetadataImplementor) getMetaData());
        String scriptOutputPath = System.getProperty("java.io.tmpdir") + "/schema.sql";
        /*
        SchemaExport schemaExport = new SchemaExport();
        FileUtils.deleteQuietly(new File(scriptOutputPath));
        EnumSet<TargetType> targetTypes = EnumSet.of(TargetType.SCRIPT);
        schemaExport.setOutputFile(scriptOutputPath);
        schemaExport.createOnly(targetTypes, getMetaData());
        */
        export.setOutputFile(scriptOutputPath);
        export.create(true, true);

        List<String> DDLs = IOUtils.readLines(new FileInputStream(scriptOutputPath), "UTF-8");
        List<String> convertedDDLs = new ArrayList<>();

        for (String DDL : DDLs) {
            if (!DDL.toLowerCase().contains("foreign key")) {
                if (DDL.toLowerCase().startsWith("create table")) {
                    convertedDDLs.add(convert(DDL));
                } else {
                    convertedDDLs.add(DDL);
                }
            }
        }

        for (String convertedDDL : convertedDDLs) {
            try {
                jdbcTemplate.execute(convertedDDL.toUpperCase());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private String convert(String ddl) throws ClassNotFoundException {
        StringBuilder convertedDDL = new StringBuilder();

        int startColumnBody = ddl.indexOf('(');
        int endColumnBody = ddl.lastIndexOf(')');

        String tableName = ddl.substring("create table ".length(), startColumnBody).trim();
        String columnBody = ddl.substring(startColumnBody + 1, endColumnBody);
        String primaryKeyDefinition = "";

        int primaryKey = columnBody.indexOf("primary key");
        primaryKeyDefinition = columnBody.substring(primaryKey);
        columnBody = columnBody.substring(0, primaryKey - 2);

        List<ColumnDefinition> columnDefinitions = Arrays.stream(columnBody.split(", ")).map(ColumnDefinition::new).collect(toList());
        columnDefinitions.add(new ColumnDefinition(primaryKeyDefinition));

        String className = getEntityClassName(tableName);

        if (StringUtils.isNotEmpty(className)) {
            Class<?> clazz = Class.forName(className);
            Field[] fields = clazz.getDeclaredFields();

            for (Field field : fields) {
                setPosition(field, columnDefinitions);
            }

            convertedDDL
                    .append("create table")
                    .append(" ")
                    .append(tableName)
                    .append(" ")
                    .append("(");

            StringJoiner columns = new StringJoiner(", ");

            columnDefinitions
                    .stream()
                    .sorted(
                            Comparator.comparingInt(ColumnDefinition::getPosition)
                                    .thenComparing(ColumnDefinition::getColumnName))
                    .forEach(entityField -> {
                        columns.add(entityField.getColumnDefinition());
                    });

            convertedDDL.append(columns.toString());

            convertedDDL.append(")");
        }
        return convertedDDL.toString();
    }

    public void setPosition(Field field, List<ColumnDefinition> columnDefinitions) {
        String name = field.getName();
        String columnName;
        int position = Integer.MAX_VALUE - 10;

        if (field.getAnnotation(Transient.class) == null) {
            Column column = field.getAnnotation(Column.class);
            ColumnPosition columnPosition = field.getAnnotation(ColumnPosition.class);

            if (column != null && !"".equals(column.name())) {
                columnName = column.name();
            } else {
                columnName = new SpringNamingStrategy().columnName(name);
            }

            if (columnPosition != null && columnPosition.value() > 0) {
                position = columnPosition.value();
            }

            if (columnName != null) {
                for (ColumnDefinition columnDefinition : columnDefinitions) {
                    if (columnDefinition.getColumnName() != null) {
                        if (columnName.toLowerCase().equals(columnDefinition.getColumnName().toLowerCase())) {
                            columnDefinition.setPosition(position);
                        }
                    }
                }
            }
        }
    }
}
