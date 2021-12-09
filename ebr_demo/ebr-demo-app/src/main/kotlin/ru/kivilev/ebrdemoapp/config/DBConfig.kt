package ru.kivilev.ebrdemoapp.config

import com.mchange.v2.c3p0.ComboPooledDataSource
import oracle.jdbc.driver.OracleDriver
import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.context.annotation.Primary
import java.beans.PropertyVetoException
import java.util.*
import javax.sql.DataSource

@Configuration
@EnableConfigurationProperties
@ConfigurationProperties(prefix = "oracle.datasource")
class DBConfig {
    private var username: String? = null
    private var password: String? = null
    private var jdbcUrl: String? = null

    @Bean
    @Primary
    fun createDBSource(): DataSource {
        val dataSource = ComboPooledDataSource()
        try {
            dataSource.driverClass = OracleDriver::class.java.name
            dataSource.jdbcUrl = jdbcUrl
            dataSource.user = username
            dataSource.password = password
            val properties = Properties()
            properties.setProperty("user", username)
            properties.setProperty("password", password)
            properties.setProperty("useUnicode", "true")
            properties.setProperty("characterEncoding", "UTF8")
            dataSource.properties = properties

            // 1 установлено для простоты демонстрации
            dataSource.initialPoolSize = 1
            dataSource.minPoolSize = 1
            dataSource.maxPoolSize = 1

            dataSource.maxStatements = 10
            dataSource.maxStatementsPerConnection = 10
            dataSource.acquireIncrement = 10
        } catch (e: PropertyVetoException) {
            e.printStackTrace()
        }
        return dataSource
    }

    fun setUsername(username: String?) {
        this.username = username
    }

    fun setPassword(password: String?) {
        this.password = password
    }

    fun setJdbcUrl(jdbcUrl: String?) {
        this.jdbcUrl = jdbcUrl
    }
}
