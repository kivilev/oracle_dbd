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

