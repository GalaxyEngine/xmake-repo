package("galaxymath")
    set_kind("library", {headeronly = true})
    set_homepage("https://github.com/GalaxyEngine/GalaxyMath")
    set_description("Header only Math Library for Galaxy Engine")

    add_urls("https://github.com/GalaxyEngine/GalaxyMath.git")

    add_versions("1.1", "ba9e6c7f9edc2bd665ab05f7b2f1550f688cdb81")
    add_versions("1.0", "875e0a42b89a7aa32013e3b979f4275f276d92e3")

    add_includedirs("include", "include/galaxymath")
    
    on_install(function (package)
        os.cp("include/*.h", package:installdir("include/galaxymath"))
        os.cp("include/*.inl", package:installdir("include/galaxymath"))
    end)
