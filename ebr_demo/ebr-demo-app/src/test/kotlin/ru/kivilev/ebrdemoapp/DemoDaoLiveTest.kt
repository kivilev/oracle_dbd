package ru.kivilev.ebrdemoapp

import org.junit.jupiter.api.Assertions.assertNotNull
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ActiveProfiles
import org.springframework.test.context.junit.jupiter.SpringExtension

@ExtendWith(SpringExtension::class)
@ActiveProfiles("dev")
@SpringBootTest
class DemoDaoLiveTest {

    @Autowired
    lateinit var demoDao: DemoDao

    @Test
    fun `Check getting result from demo function`() {
        val functionResult = demoDao.getDemoFuncResult()
        val result = if (functionResult.isPresent) functionResult.get() else null
        assertNotNull(result)
        println("Result of function: $result")
    }

    @Test
    fun `Getting database default edition`() {
        val databaseDefaultEdition = demoDao.getDatabaseDefaultEdition()
        assertNotNull(databaseDefaultEdition)
        println("Database default edition: $databaseDefaultEdition")
    }
}
