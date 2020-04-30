/*
 * Copyright (c) 2020. Пример использования именованных блокировок на уровне JavaApp.
 * Автор: Кивилев Денис
 *
 * Репозиторий: https://github.com/kivilev/oracle_dbd
 * Телеграм - https://t.me/oracle_dbd
 * Ютуб - https://www.youtube.com/channel/UC4f5yrDUHl0R_twMttfL7XA
 */

package ru.kivilev.dao;

import com.google.common.collect.ImmutableMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;
import ru.kivilev.OracleLockDemoApp;

import javax.sql.DataSource;
import java.math.BigDecimal;
import java.sql.Types;

@Repository
public class LockDaoImpl implements LockDao {
    private static final Logger log = LoggerFactory.getLogger(LockDao.class);

    private final SimpleJdbcCall allocateLockProc;
    private final SimpleJdbcCall releaseLockProc;

    @Autowired
    public LockDaoImpl(DataSource dataSource) {
        // процедура получения блокировки
        allocateLockProc = new SimpleJdbcCall(dataSource)
                .withCatalogName("lock_control_pack")
                .withFunctionName("allocate_lock")
                .declareParameters(
                        new SqlOutParameter("result", Types.VARCHAR),
                        new SqlParameter("p_lock_name", Types.VARCHAR)
                )
                .withoutProcedureColumnMetaDataAccess();
        allocateLockProc.compile();

        //процедура освобождения блокировки
        releaseLockProc = new SimpleJdbcCall(dataSource)
                .withCatalogName("lock_control_pack")
                .withProcedureName("release_lock")
                .declareParameters(
                        new SqlParameter("p_lock_handle", Types.VARCHAR)
                )
                .withoutProcedureColumnMetaDataAccess();

        releaseLockProc.compile();
    }

    @Override
    public String allocateExclusiveLock(String lockName) {
        SqlParameterSource in = (new MapSqlParameterSource())
                .addValue("p_lock_name", lockName);
        String lock_handle = allocateLockProc.executeFunction(String.class, in);
        log.info("lock handle: " + lock_handle);
        return lock_handle;
    }

    @Override
    public void releaseExclusiveLock(String lockHandle) {
        SqlParameterSource in = (new MapSqlParameterSource())
                .addValue("p_lock_handle", lockHandle);
        releaseLockProc.execute(in);
    }

}
