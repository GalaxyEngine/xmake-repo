package("galaxyscript")
    set_homepage("https://github.com/GalaxyEngine/GalaxyScript2")
    set_description("Scripting library designed for C++ development")
    add_includedirs("include", "include/galaxyscript")

    add_urls("https://github.com/GalaxyEngine/GalaxyScript2/archive/refs/tags/$(version).zip")
    add_urls("https://github.com/GalaxyEngine/GalaxyScript2.git")

    add_versions("v1.0", "fd6bd5a6f9c941abef3d7b906352fec1a75a1471")

    add_deps("cpp_serializer")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")
            set_languages("c++20")

            add_repositories("galaxy-repo https://github.com/GalaxyEngine/xmake-repo")
            add_requires("cpp_serializer")

            target("galaxyscript")
                set_kind("static")

                add_includedirs("include")
                add_headerfiles("include/**.h")
                add_files("src/**.cpp")

                if (is_plat("linux")) then
                    add_cxxflags("-fPIC")
                end

                add_packages("cpp_serializer")
        ]])
        import("package.tools.xmake").install(package, configs)

        os.cp("include/*.h", package:installdir("include/galaxyscript"))
        os.cp("include/*.inl", package:installdir("include/galaxyscript"))
    end)
