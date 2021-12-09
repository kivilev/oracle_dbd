package ru.kivilev.ebrdemoapp

import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.stereotype.Component
import ru.kivilev.ebrdemoapp.config.DBEditionConfig
import java.time.ZonedDateTime

interface DbEditionService {
    fun getDatabaseDefaultEdition(): String
}

@Component
@EnableConfigurationProperties(DBEditionConfig::class)
class DbEditionServiceImpl(
    private val demoDao: DemoDao,
    private val dbEditionConfig: DBEditionConfig
) :
    DbEditionService {

    private var lastRefresh: ZonedDateTime = ZonedDateTime.now() - dbEditionConfig.refreshPeriod
    private var currentDbDefaultEdition: String = ""

    override fun getDatabaseDefaultEdition(): String {
        if (isNeedToRefresh()) {
            currentDbDefaultEdition = demoDao.getDatabaseDefaultEdition()
            lastRefresh = ZonedDateTime.now()
        }
        return currentDbDefaultEdition
    }

    private fun isNeedToRefresh() = ZonedDateTime.now() - dbEditionConfig.refreshPeriod >= lastRefresh
}