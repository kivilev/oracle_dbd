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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.core.simple.SimpleJdbcCall;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.Types;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Repository
public class ClientDaoImpl implements ClientDao {

    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Autowired
    public ClientDaoImpl(DataSource dataSource) {
        namedParameterJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
    }

    @Override
    public void setNodeName(Long clientId, String nodeName) {
        namedParameterJdbcTemplate.update(
                "update client_demo_lock c " +
                        "set c.node_name = :node_name " +
                        "where client_id = :client_id",
                ImmutableMap.of(
                        "node_name", nodeName,
                        "client_id", clientId));
    }

    @Override
    public void sleep(int second) {
        namedParameterJdbcTemplate.execute(
                "call dbms_session.sleep(:second)",
                ImmutableMap.of("second", second),
                (preparedStatement) -> {
                    preparedStatement.execute();
                    return null;
                });
    }
}
