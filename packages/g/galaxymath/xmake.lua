package("galaxymath")
    set_kind("headeronly")
    set_homepage("https://github.com/GalaxyEngine/GalaxyMath")
    set_description("Header only Math Library for Galaxy Engine")
    set_policy("package.strict_compatibility", true)

    add_urls("https://github.com/GalaxyEngine/GalaxyMath.git")

    add_versions("1.0", "ce572412e5bb7c98b957fe58f2d00ee58a1fa9cf")
    
    on_install(function (package)
        os.cp("include", package:installdir())
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            void test() {
                Vec3f vec;
                vec.Length();
            }
        ]]}, {configs = {languages = "c++20"}}))
    end)
