package ru.oralcedbd.openapikiviwallet.dao

import org.junit.jupiter.api.extension.ExtendWith
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.test.context.SpringBootTest
import org.springframework.test.context.ActiveProfiles
import org.springframework.test.context.junit.jupiter.SpringExtension

@ExtendWith(SpringExtension::class)
@ActiveProfiles("dev")
@SpringBootTest
class ClientDaoLiveTest {

    @Autowired
    lateinit var clientDao: ClientDao

}