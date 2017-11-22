
maven_jar(
    name = "net_java_dev_jna_jna_platform",
    artifact = "net.java.dev.jna:jna-platform:4.4.0",
)

maven_jar(
    name = "de_flapdoodle_embed_de_flapdoodle_embed_process",
    artifact = "de.flapdoodle.embed:de.flapdoodle.embed.process:2.0.1",
)

maven_jar(
    name = "org_apache_commons_commons_compress",
    artifact = "org.apache.commons:commons-compress:1.14",
)

maven_jar(
    name = "org_slf4j_slf4j_api",
    artifact = "org.slf4j:slf4j-api:1.7.25",
)

maven_jar(
    name = "commons_io_commons_io",
    artifact = "commons-io:commons-io:2.5",
)

maven_jar(
    name = "net_java_dev_jna_jna",
    artifact = "net.java.dev.jna:jna:4.4.0",
)

maven_jar(
    name = "org_apache_commons_commons_lang3",
    artifact = "org.apache.commons:commons-lang3:3.6",
)

maven_jar(
    name = "com_wix_wix_embedded_mysql",
    artifact = "com.wix:wix-embedded-mysql:3.0.0",
)

maven_jar(
    name = "com_wix_wix_embedded_mysql_download_and_extract_jar_with_dependencies",
    artifact = "com.wix:wix-embedded-mysql-download-and-extract:jar:jar-with-dependencies:3.0.0",
)

maven_jar(
    name = "junit_junit",
    artifact = "junit:junit:4.12",
)

load(":mysql_installer.bzl", "mysql_default_version", "mysql")
mysql_default_version()
mysql("5.7", "latest")