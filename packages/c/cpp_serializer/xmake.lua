package("cpp_serializer")
    set_kind("library", {headeronly = true})
    set_homepage("https://github.com/Maisquasar/CppSerializer")
    set_description("Header only Serializer Library")

    add_urls("https://github.com/Maisquasar/CppSerializer.git")

    add_versions("1.0", "00161705035a3eda8e9a348f9f6792badeac24fe")

    add_includedirs("include", "include/cpp_serializer")
    
    on_install(function (package)
        os.cp("include/*.h", package:installdir("include/cpp_serializer"))
        os.cp("include/*.inl", package:installdir("include/cpp_serializer"))
    end)
