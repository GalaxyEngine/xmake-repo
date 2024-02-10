package("galaxyscript")
    set_homepage("https://github.com/GalaxyEngine/GalaxyScript")
    set_description("")
    add_includedirs("include", "include/galaxyscript")

    add_urls("git@github.com:GalaxyEngine/GalaxyScript.git")
    add_versions("v1.0", "95fa70363e61a0aaacce4a30ffa1eebebd3ecbc5")

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
                add_files("src/**.cpp")
                add_headerfiles("include/**.h")
        ]])
        import("package.tools.xmake").install(package, configs)

        os.cp("include/*.h", package:installdir("include/galaxyscript"))
        os.cp("include/*.inl", package:installdir("include/galaxyscript"))
    end)
