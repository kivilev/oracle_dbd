/*
 * Copyright (c) 2020. Пример использования именованных блокировок на уровне JavaApp.
 * Автор: Кивилев Денис
 *
 * Репозиторий: https://github.com/kivilev/oracle_dbd
 * Телеграм - https://t.me/oracle_dbd
 * Ютуб - https://www.youtube.com/channel/UC4f5yrDUHl0R_twMttfL7XA
 */

package ru.kivilev.config;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import javax.sql.DataSource;
import java.beans.PropertyVetoException;
import java.sql.SQLException;
import java.util.Properties;

@Configuration
@EnableConfigurationProperties
@ConfigurationProperties(prefix = "oracle.datasourse")
public class DBConfig {
    private String username;
    private String password;
    private String jdbcUrl;

    @Bean
    @Primary
    public DataSource createDBSource() throws SQLException {
        ComboPooledDataSource dataSource = new ComboPooledDataSource();
        try {
            dataSource.setDriverClass(oracle.jdbc.driver.OracleDriver.class.getName());
            dataSource.setJdbcUrl(jdbcUrl);
            dataSource.setUser(username);
            dataSource.setPassword(password);

            Properties properties = new Properties();
            properties.setProperty("user", username);
            properties.setProperty("password", password);
            properties.setProperty("useUnicode", "true");
            properties.setProperty("characterEncoding", "UTF8");
            dataSource.setProperties(properties);

            // set options
            dataSource.setMaxStatements(10);
            dataSource.setMaxStatementsPerConnection(10);
            dataSource.setInitialPoolSize(5);
            dataSource.setMinPoolSize(5);
            dataSource.setAcquireIncrement(10);
            dataSource.setMaxPoolSize(5);
            dataSource.setMaxIdleTime(1);
            //dataSource.
        } catch (
                PropertyVetoException e) {
            e.printStackTrace();
        }
        return dataSource;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setJdbcUrl(String jdbcUrl) {
        this.jdbcUrl = jdbcUrl;
    }
}
