def _impl_mysql_binary(repository_ctx):
  #the `binary` filegroup evaluates to a single file which is used as a marker
  #for the jvm test to the location of the cache folder
  #this is needed because depending on folders is an anti-practice in Bazel
  #and support for it in sandboxing, remote caching and remote execution is unclear 
  build = """
filegroup(
          name = "binary_dir_contents" ,
          srcs = glob(["downloaded_mysql/**"]),
        )
filegroup(
          name = "binary" ,
          srcs = glob(["downloaded_mysql/**/*.tar.gz"]),
          data = [":binary_dir_contents"],
          visibility = ['//visibility:public']
        )
"""
  repository_ctx.file("BUILD", build)
  path_to_download_to = repository_ctx.path("downloaded_mysql")

  major, minor = repository_ctx.attr.major_version, repository_ctx.attr.minor_version

#  args = [repository_ctx.executable._java.path,  //replace /usr/bin/java with declared dependency
  args = ["java",
          "-jar",
          repository_ctx.path(repository_ctx.attr._mysql_downloader_and_extractor),
          path_to_download_to,
          major,
          minor
  ]
  exec_result = repository_ctx.execute(args, timeout = 60*30, quiet = False)
  if exec_result.return_code != 0:
      fail("\ncould not download mysql {major}.{minor}!\n".format(major=major, minor=minor))


_mysql_binary_with_mandatory_skylark_name = repository_rule(
    implementation=_impl_mysql_binary,
    attrs = {
      "major_version": attr.string(mandatory=True),
      "minor_version": attr.string(mandatory=True),
      #repository_ctx.path doesn't allow a label
      #https://github.com/bazelbuild/bazel/issues/3438
      "_mysql_downloader_and_extractor": attr.label(default=Label("@com_wix_wix_embedded_mysql_download_and_extract_jar_with_dependencies//jar:wix-embedded-mysql-download-and-extract-3.0.0-jar-with-dependencies.jar")),
 #     "_java": attr.label(executable=True, cfg="host", default=Label("@bazel_tools//tools/jdk:java"), allow_files=True),
      } )

def mysql_default_version():
  _mysql_binary_with_mandatory_skylark_name(
      #the below name and the literal `downloaded_mysql` are duplicated in ITEmbeddedMysql.scala
      name = "mysql_default_version",
      major_version = "5.6",
      minor_version = "latest"
)
def mysql(major_version, minor_version):
  _mysql_binary_with_mandatory_skylark_name(
      name = "mysql_" + major_version + "_" + minor_version,
      major_version = major_version,
      minor_version = minor_version
)