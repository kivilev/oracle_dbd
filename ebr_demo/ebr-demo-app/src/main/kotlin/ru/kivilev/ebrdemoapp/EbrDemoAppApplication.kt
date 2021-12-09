package ru.kivilev.ebrdemoapp

import org.slf4j.LoggerFactory
import org.springframework.boot.CommandLineRunner
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class EbrDemoAppApplication(
    private val demoDao: DemoDao,
    private val dbEditionService: DbEditionService
) : CommandLineRunner {
    private val log = LoggerFactory.getLogger(EbrDemoAppApplication::class.java)
    private var currentDbEdition = dbEditionService.getDatabaseDefaultEdition()
    private var previousDbEdition = dbEditionService.getDatabaseDefaultEdition()

    override fun run(vararg args: String?) {
        log.info("Run application...")

        while (true) {
            currentDbEdition = dbEditionService.getDatabaseDefaultEdition()
            if (currentDbEdition != previousDbEdition) {
                //log.info("Default database edition was changed to $currentDbEdition")
                demoDao.setSessionDefaultEdition(currentDbEdition)
                previousDbEdition = currentDbEdition
                //log.info("Session edition was changed to $currentDbEdition")
            }
            log.info(demoDao.getDemoFuncResult().get())
            Thread.sleep(2000)
        }

    }
}

fun main(args: Array<String>) {
    runApplication<EbrDemoAppApplication>(*args)
}
