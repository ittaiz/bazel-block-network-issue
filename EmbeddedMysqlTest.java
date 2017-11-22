import static com.wix.mysql.EmbeddedMysql.anEmbeddedMysql;
import static com.wix.mysql.distribution.Version.v5_6_latest;
import static com.wix.mysql.distribution.Version.v5_7_latest;

import com.wix.mysql.EmbeddedMysql;
import com.wix.mysql.config.DownloadConfig;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.JUnit4;

@RunWith(JUnit4.class)
public class EmbeddedMysqlTest {

  @Test
  public void test() {

    EmbeddedMysql mysqld = anEmbeddedMysql(
        v5_7_latest,
        DownloadConfig.aDownloadConfig()
            .withCacheDir(markerToCacheDir(System.getProperty("example.custom.mysql.version")))
            .build()
    ).start();
    mysqld.stop();

    EmbeddedMysql defaultMysqld = anEmbeddedMysql(
        v5_6_latest,
        DownloadConfig.aDownloadConfig()
            .withCacheDir(Paths.get("external/mysql_default_version/downloaded_mysql").toString())
            .build()
    ).start();
    defaultMysqld.stop();
  }

  private String markerToCacheDir(String cacheMarker) {
    return traverseTwoDirectoriesUpToTheCacheDir(Paths.get(cacheMarker));
  }

  private String traverseTwoDirectoriesUpToTheCacheDir(Path marker) {
    //the marker points to a file two directories deep from the cache dir
    //by mysql_installer.bzl and embedded-mysql conventions
    return marker.getParent().getParent().toAbsolutePath().toString();
  }

}
