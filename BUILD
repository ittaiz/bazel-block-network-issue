java_test(
    name = "EmbeddedMysqlTest",
    srcs = ["EmbeddedMysqlTest.java"],
    test_class = "EmbeddedMysqlTest",
    tags = ["block-network"],
    deps = [
        "@com_wix_wix_embedded_mysql//jar",
        "@de_flapdoodle_embed_de_flapdoodle_embed_process//jar",
        "@net_java_dev_jna_jna_platform//jar",
        "@org_apache_commons_commons_compress//jar",
        "@org_slf4j_slf4j_api//jar",
        "@commons_io_commons_io//jar",
        "@net_java_dev_jna_jna//jar",
        "@org_apache_commons_commons_lang3//jar",
        "@junit_junit//jar",
    ],
    data = [
        "@mysql_5.7_latest//:binary",
    ],
    jvm_flags = ["-Djava.io.tmpdir=/tmp", "-Dexample.custom.mysql.cache.dir=$(location @mysql_5.7_latest//:binary)"],
)