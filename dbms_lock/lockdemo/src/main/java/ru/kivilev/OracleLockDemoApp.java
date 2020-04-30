package ru.kivilev;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import ru.kivilev.dao.ClientDao;
import ru.kivilev.dao.LockDao;

import java.sql.SQLException;

@SpringBootApplication
public class OracleLockDemoApp implements CommandLineRunner {
    private static final Logger log = LoggerFactory.getLogger(OracleLockDemoApp.class);

    @Autowired
    LockDao lockDao;

    @Autowired
    ClientDao clientDao;

    public static void main(String[] args) {
        SpringApplication.run(OracleLockDemoApp.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        log.info("==============");

        // получаем параметры
        if (args.length != 2) {
            log.warn("Must be two parameters!");
            return;
        }
        Long clientId = Long.parseLong(args[0]);
        String nodeName = args[1];
        log.info("Client id: " + clientId + ". Node name: " + nodeName);

        // получаем блокировку
        String lockName = "LOCK$CLIENT$" + clientId;//уникальное имя блокировки
        log.info("getting lock "+lockName+"...");

        String lockHandle = null;
        try {
            lockHandle = lockDao.allocateExclusiveLock(lockName);
        } catch (Exception e) {
            log.error("Was error in JavaApp when getting lock: " + lockName + ". Erorr: " + e.getMessage());
            return;
        }

        // обновляем клиента
        log.info("updating client...");
        int sec = 10;
        clientDao.setNodeName(clientId, nodeName);
        log.info("sleeping "+sec+" sec...");
        clientDao.sleep(10);

        // освобождаем блокировку
        log.info("releasing lock...");
        lockDao.releaseExclusiveLock(lockHandle);

        log.info("==============");
    }
}
