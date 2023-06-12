package("galaxymath")
    set_kind("static")
    set_homepage("https://github.com/GalaxyEngine/GalaxyMath")
    set_description("Static Math Library for Galaxy Engine")
    set_policy("package.strict_compatibility", true)

    add_urls("https://github.com/GalaxyEngine/GalaxyMath.git")

    add_includedirs("include")

    add_versions("06.12.2023", "8e6511e3d9198a07a638b74385f2cfc9f5458ff1")
    
    on_install(function (package)
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            void test() {
                Vec3f vec;
                vec.Length();
            }
        ]]}, {configs = {languages = "c++20"}}))
    end)
