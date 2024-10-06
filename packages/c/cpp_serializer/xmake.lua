package("cpp_serializer")
    set_kind("library", {headeronly = true})
    set_homepage("https://github.com/Maisquasar/CppSerializer")
    set_description("Header only Serializer Library")

    add_urls("https://github.com/Maisquasar/CppSerializer.git")

    add_versions("1.0", "908038c832aff9927078a57639bf4af91d5a5429")
    add_versions("1.1", "e026931007bfddb36bce787fc8d822ad09d2932d")
    add_versions("1.2", "905028d80bb7374bbff05ca3c99c9cc2e6c0702f")
    add_versions("1.3", "c8c154428cd60fe55e368c9c07ee73604ce6cdee")
    add_versions("1.3.1", "4044d5bd6eaec18e722e8af1a42a678fcedaaaa1")
    add_versions("1.4", "0987e0bd48637797ea600a465ccca256a2e3d8ee")

    add_includedirs("include", "include/cpp_serializer")
    
    on_install(function (package)
        os.cp("include/*.h", package:installdir("include/cpp_serializer"))
        os.cp("include/*.inl", package:installdir("include/cpp_serializer"))
    end)
