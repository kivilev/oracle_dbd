package ru.kivilev.ebrdemoapp

import org.springframework.jdbc.core.SqlOutParameter
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate
import org.springframework.jdbc.core.simple.SimpleJdbcCall
import org.springframework.stereotype.Repository
import java.sql.PreparedStatement
import java.sql.Types
import java.util.*
import javax.sql.DataSource

interface DemoDao {
    fun getDemoFuncResult(): Optional<String>
    fun getDatabaseDefaultEdition(): String
    fun setSessionDefaultEdition(editionName: String)
}

@Repository
class DemoDaoImpl(dataSource: DataSource) : DemoDao {

    val demoFunctionCall = SimpleJdbcCall(dataSource)
    val namedParameterJdbcTemplate = NamedParameterJdbcTemplate(dataSource)

    init {
        demoFunctionCall
            .withFunctionName("hr_ebr_func")
            .withNamedBinding()
            .withoutProcedureColumnMetaDataAccess()
            .declareParameters(
                SqlOutParameter("result", Types.VARCHAR)
            ).also(SimpleJdbcCall::compile)
    }

    override fun getDemoFuncResult(): Optional<String> {
        val resultParams = demoFunctionCall.execute()
        return Optional.ofNullable(resultParams.getOrDefault("result", null) as String)
    }

    override fun getDatabaseDefaultEdition(): String {
        return namedParameterJdbcTemplate.query(DB_DEFAULT_EDITION_SQL)
        { rs, _ -> rs.getString("property_value") }.map { it.uppercase() }.first()
    }

    override fun setSessionDefaultEdition(editionName: String) {
        namedParameterJdbcTemplate.execute(SET_DEFAULT_EDITION + editionName) { preparedStatement: PreparedStatement ->
            preparedStatement.execute()
            null
        }
    }

    private companion object {
        const val DB_DEFAULT_EDITION_SQL = "select property_value \n" +
            "  from database_properties \n" +
            " where property_name = 'DEFAULT_EDITION'"
        const val SET_DEFAULT_EDITION = "alter session set edition = "
    }
}



