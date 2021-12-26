package ru.oralcedbd.openapikiviwallet.dao

import oracle.jdbc.OracleTypes
import org.springframework.jdbc.core.SqlOutParameter
import org.springframework.jdbc.core.SqlParameter
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate
import org.springframework.jdbc.core.simple.SimpleJdbcCall
import org.springframework.stereotype.Repository
import ru.oralcedbd.openapikiviwallet.model.Client
import java.sql.Types
import java.util.*
import javax.sql.DataSource


interface ClientDao {
    fun createClient(client: Client): Long
    fun getClient(id: Long): Optional<Client>
    fun deactivateClient(id: Long)
}

@Repository
class ClientDaoImpl(dataSource: DataSource) : ClientDao {

    private val namedParameterJdbcTemplate: NamedParameterJdbcTemplate = NamedParameterJdbcTemplate(dataSource)
    private val createClientFunc: SimpleJdbcCall = SimpleJdbcCall(dataSource)
    private val deactivateClientProc: SimpleJdbcCall = SimpleJdbcCall(dataSource)

    init {
        createClientFunc.withCatalogName("client_api_pack")
            .withFunctionName("create_client")
            .withoutProcedureColumnMetaDataAccess()
            .withNamedBinding()
            .declareParameters(
                SqlOutParameter("client_id", Types.BIGINT),
                SqlParameter("p_create_dtime", Types.DATE),
                SqlParameter("p_first_name", Types.VARCHAR),
                SqlParameter("p_last_name", Types.VARCHAR),
                SqlParameter("p_middle_name", Types.VARCHAR),
                SqlParameter("p_email", Types.VARCHAR),
                SqlParameter("p_phone", Types.VARCHAR)
            ).also(SimpleJdbcCall::compile)

        deactivateClientProc.withCatalogName("client_api_pack")
            .withProcedureName("deactivate_client")
            .withoutProcedureColumnMetaDataAccess()
            .withNamedBinding()
            .declareParameters(
                SqlParameter("p_client_id", OracleTypes.NUMERIC)
            ).also(SimpleJdbcCall::compile)
    }

    override fun createClient(client: Client): Long {
        with(client) {
            val params = mapOf(
                "p_create_dtime" to createDtime,
                "p_first_name" to firstName,
                "p_last_name" to lastName,
                "p_middle_name" to middleName,
                "p_email" to email,
                "p_phone" to phone
            )
            val resultParams = createClientFunc.execute(params)
            return resultParams["client_id"] as Long
        }
    }

    override fun getClient(id: Long): Optional<Client> {
        return Optional.ofNullable(
            namedParameterJdbcTemplate.query(
                GET_CLIENT_SQL,
                mapOf("v_client_id" to id)
            ) { rs, _ ->
                Client(
                    rs.getLong("client_id"),
                    rs.getInt("is_active"),
                    MapperUtils.convertDateToZonedDateTime(rs.getTimestamp("create_dtime")),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getString("middle_name") ?: "",
                    rs.getString("email"),
                    rs.getString("phone")
                )
            }.firstOrNull()
        )
    }

    override fun deactivateClient(id: Long) {
        val params = mapOf("p_client_id" to id)
        deactivateClientProc.execute(params)
    }

    private companion object {
        val GET_CLIENT_SQL = """
            select client_id, is_active, create_dtime, first_name, last_name, middle_name, email, phone
              from client
             where client_id = :v_client_id
        """.trimMargin()
    }
}


