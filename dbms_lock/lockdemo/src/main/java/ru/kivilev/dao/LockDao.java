/*
 * Copyright (c) 2020. Пример использования именованных блокировок на уровне JavaApp.
 * Автор: Кивилев Денис
 *
 * Репозиторий: https://github.com/kivilev/oracle_dbd
 * Телеграм - https://t.me/oracle_dbd
 * Ютуб - https://www.youtube.com/channel/UC4f5yrDUHl0R_twMttfL7XA
 */

package ru.kivilev.dao;

import org.springframework.stereotype.Component;

public interface LockDao {

    String allocateExclusiveLock(String lockName);

    void releaseExclusiveLock(String lockHandle);
}
