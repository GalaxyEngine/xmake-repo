package("cpp_serializer")
    set_kind("library", {headeronly = true})
    set_homepage("https://github.com/Maisquasar/CppSerializer")
    set_description("Header only Serializer Library")

    add_urls("https://github.com/Maisquasar/CppSerializer.git")

    add_versions("1.0", "908038c832aff9927078a57639bf4af91d5a5429")
    add_versions("1.1", "a6f1216ee45fd75feaf727f12f07e72f3de3fa15")

    add_includedirs("include", "include/cpp_serializer")
    
    on_install(function (package)
        os.cp("include/*.h", package:installdir("include/cpp_serializer"))
        os.cp("include/*.inl", package:installdir("include/cpp_serializer"))
    end)
