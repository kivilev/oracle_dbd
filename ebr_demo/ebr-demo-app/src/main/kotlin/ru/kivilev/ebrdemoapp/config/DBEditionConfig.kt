package ru.kivilev.ebrdemoapp.config

import org.springframework.boot.context.properties.ConfigurationProperties
import java.time.Duration

@ConfigurationProperties(prefix = "edition.cache")
class DBEditionConfig {
    lateinit var refreshPeriod: Duration
}