package ru.kivilev.dao;

public interface ClientDao {

    void setNodeName(Long clientId, String nodeName);

    void sleep(int second);

}
