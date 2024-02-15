package("galaxyscript")
    set_homepage("https://github.com/GalaxyEngine/GalaxyScript")
    set_description("")
    add_includedirs("include", "include/galaxyscript")

    add_urls("git@github.com:GalaxyEngine/GalaxyScript.git")

    add_versions("v1.0", "95fa70363e61a0aaacce4a30ffa1eebebd3ecbc5")
    add_versions("v1.1", "248ba01943c2a21a83e8c011d13ad9ba56bda6dd")
    add_versions("v1.2", "bc358e6ccc5be8e256b42cefed920fb90bc4bd1f")
    add_versions("v1.3", "0446b4b3e2b83666e0bfc9e7ef1ef496696828de")

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
