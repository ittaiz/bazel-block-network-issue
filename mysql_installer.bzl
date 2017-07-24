def _impl_mysql_binary(repository_ctx):
  _internal_mysql_binary(
      repository_ctx,
      repository_ctx.attr.major_version,
      repository_ctx.attr.minor_version,
  )

def _internal_mysql_binary(repository_ctx, major_version, minor_version):
  build = """filegroup(
          name = "binary" ,
          srcs = ["downloaded_mysql"],
          visibility = ['//visibility:public']
        )"""
  repository_ctx.file("BUILD", build)
  path_to_download_to = repository_ctx.path("downloaded_mysql")

#  args = [repository_ctx.executable._java.path,  //replace /usr/bin/java with declared dependency
  args = ["java",
          "-jar",
          repository_ctx.path(repository_ctx.attr._mysql_downloader_and_extractor),
          path_to_download_to,
          major_version,
          minor_version
  ]
  repository_ctx.execute(args, quiet = False)

_mysql_binary_with_mandatory_skylark_name = repository_rule(
    implementation=_impl_mysql_binary,
	attrs = {
			"major_version": attr.string(mandatory=True),
			"minor_version": attr.string(mandatory=True),
      #repository_ctx.path doesn't allow a label and for some reason
      "_mysql_downloader_and_extractor": attr.label(default=Label("@com_wix_wix_embedded_mysql_download_and_extract_jar_with_dependencies//jar:wix-embedded-mysql-download-and-extract-2.2.9-jar-with-dependencies.jar")),
 #     "_java": attr.label(executable=True, cfg="host", default=Label("@bazel_tools//tools/jdk:java"), allow_files=True),
			}
)

def mysql_binary(major_version, minor_version):
  _mysql_binary_with_mandatory_skylark_name(
      name = "mysql_" + major_version + "_" + minor_version,
      major_version = major_version,
      minor_version = minor_version
)