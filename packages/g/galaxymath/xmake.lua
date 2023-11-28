package("galaxymath")
    set_kind("headeronly")
    set_homepage("https://github.com/GalaxyEngine/GalaxyMath")
    set_description("Header only Math Library for Galaxy Engine")
    set_policy("package.strict_compatibility", true)

    add_urls("https://github.com/GalaxyEngine/GalaxyMath.git")

    add_versions("1.0", "c43f6328e34b2859c1cf84dcb131cf00a2c36147")

    add_includedirs("include", "include/galaxymath")
    
    on_install(function (package)
        os.cp("include/*.h", package:installdir("include/galaxymath"))
        os.cp("include/*.inl", package:installdir("include/galaxymath"))
    end)
