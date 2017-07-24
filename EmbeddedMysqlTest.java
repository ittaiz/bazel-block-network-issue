import com.wix.mysql.config.DownloadConfig;
import org.junit.runners.JUnit4;
import org.junit.runner.RunWith;
import org.junit.Test;
import com.wix.mysql.EmbeddedMysql;

import static com.wix.mysql.EmbeddedMysql.anEmbeddedMysql;
import static com.wix.mysql.distribution.Version.v5_7_latest;

@RunWith(JUnit4.class)
public class EmbeddedMysqlTest {
    @Test
    public void test(){

        EmbeddedMysql mysqld = anEmbeddedMysql(
                v5_7_latest,
                DownloadConfig.aDownloadConfig().withCacheDir(mysqlBazelBinaryDir()).build()
        ).start();
        mysqld.stop();
    }

    private String mysqlBazelBinaryDir() {
        return System.getProperty("example.custom.mysql.cache.dir");
    }
}
