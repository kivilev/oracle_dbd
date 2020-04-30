package ru.kivilev.dao;

import org.springframework.stereotype.Component;

public interface LockDao {

    String allocateExclusiveLock(String lockName);

    void releaseExclusiveLock(String lockHandle);
}
