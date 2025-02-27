package("galaxymath")
    set_kind("library", {headeronly = true})
    set_homepage("https://github.com/GalaxyEngine/GalaxyMath")
    set_description("Header only Math Library for Galaxy Engine")

    add_urls("https://github.com/GalaxyEngine/GalaxyMath.git")

    add_versions("1.5", "74701c3896dfe513ce8132a0862fc6642bf1cb50")
    add_versions("1.4", "9aeedc9d5159fd91997d428c592aaae153ae2b67")
    add_versions("1.3", "6f84f4f2c686ad8f6c542ff42b0854e07ac643c1")
    add_versions("1.2", "1c2c473c534b73963b0d993e19fd58cf61a5e57e")
    add_versions("1.1", "ba9e6c7f9edc2bd665ab05f7b2f1550f688cdb81")
    add_versions("1.0", "875e0a42b89a7aa32013e3b979f4275f276d92e3")

    add_includedirs("include", "include/galaxymath")
    
    on_install(function (package)
        os.cp("include/*.h", package:installdir("include/galaxymath"))
        os.cp("include/*.inl", package:installdir("include/galaxymath"))
    end)
