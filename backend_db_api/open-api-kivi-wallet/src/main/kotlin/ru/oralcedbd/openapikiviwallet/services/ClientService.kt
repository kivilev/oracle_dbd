package ru.oralcedbd.openapikiviwallet.services

import org.slf4j.LoggerFactory
import org.springframework.stereotype.Component
import ru.oralcedbd.openapikiviwallet.api.v1.models.ClientCreateRequestDto
import ru.oralcedbd.openapikiviwallet.api.v1.models.ClientIdResponseDto
import ru.oralcedbd.openapikiviwallet.api.v1.models.ClientResponseDto
import ru.oralcedbd.openapikiviwallet.dao.ClientDao
import ru.oralcedbd.openapikiviwallet.model.Client
import java.time.ZonedDateTime
import java.util.*

interface ClientService {
    fun createClient(clientCreateRequestDto: ClientCreateRequestDto): ClientIdResponseDto
    fun getClient(id: Long): Optional<ClientResponseDto>
    fun deactivateClient(id: Long)
}

@Component
class ClientServiceImpl(private val clientDao: ClientDao) : ClientService {

    val logger = LoggerFactory.getLogger(ClientServiceImpl::class.java)

    override fun createClient(clientCreateRequestDto: ClientCreateRequestDto): ClientIdResponseDto {
        val client = mapDtoToClient(clientCreateRequestDto)
        client.createDtime = ZonedDateTime.now()
        val clientId = clientDao.createClient(client)
        return ClientIdResponseDto(clientId)
    }

    override fun getClient(id: Long): Optional<ClientResponseDto> {
        val client = clientDao.getClient(id)

        if (client.isPresent) {
            return Optional.of(mapClientToDto(client.get()))
        }
        return Optional.empty()
    }

    override fun deactivateClient(id: Long) {
        try {
            clientDao.deactivateClient(id)
        } catch (e: Exception) {
            logger.warn("DeactivateClient. Client_id: ${id}. DaoFullError: ${e.toString()}")
        }
    }

    private fun mapClientToDto(client: Client) =
        with(client) {
            ClientResponseDto(
                id,
                isActive == 1,
                createDtime,
                firstName,
                lastName,
                middleName,
                email,
                phone
            )
        }

    private fun mapDtoToClient(client: ClientCreateRequestDto): Client {
        with(client) {
            return Client(
                null,
                null,
                null,
                firstName,
                lastName,
                this.middleName,
                email,
                phone
            )
        }
    }

}