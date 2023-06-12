package("galaxymath")
    set_kind("static")
    set_homepage("https://github.com/GalaxyEngine/GalaxyMath")
    set_description("Static Math Library for Galaxy Engine")
    set_policy("package.strict_compatibility", true)

    add_urls("https://github.com/GalaxyEngine/GalaxyMath.git")

    add_includedirs("include")

    add_versions("06.12.2023", "65bb5d5d18b356af0a84a8aafc5023fe24b75a84")
    
    on_install(function (package)
        import("package.tools.xmake").install(package)
    end)

    on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
            void test() {
                Vec3f vec;
                vec.Length();
            }
        ]]}, {configs = {languages = "c++14"}}))
    end)
