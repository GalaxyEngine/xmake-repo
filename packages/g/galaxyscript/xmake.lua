package("galaxyscript")
    set_homepage("https://github.com/GalaxyEngine/GalaxyScript")
    set_description("")
    add_includedirs("include", "include/galaxyscript")

    add_urls("https://github.com/GalaxyEngine/GalaxyScript.git")

    add_versions("v1.1-galaxyengine", "v1.1-galaxyengine")
    add_versions("v1.0-galaxyengine", "v1.0-galaxyengine")
    add_versions("v1.0", "9bda2bf1b133a53574db3ec8069106bb755a33f6")

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
