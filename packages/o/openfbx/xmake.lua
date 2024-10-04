package("openfbx")
    set_homepage("https://github.com/nem0/OpenFBX")
    set_description("Lightweight open source FBX importer")
    set_license("MIT")
    add_includedirs("include", "include/openfbx")

    add_urls("https://github.com/nem0/OpenFBX.git")
    add_versions("2024.02.16", "eefc3df905f762226df980ca95a6c4bac1d0c1ae")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.release", "mode.debug")

            target("openfbx")
                set_kind("static")

                add_includedirs("src")
                add_headerfiles("src/**.h")
                add_files("src/**.cpp")
                add_files("src/**.c")

                if (is_plat("linux")) then
                    add_cxxflags("-fPIC")
                end
        ]])
        import("package.tools.xmake").install(package, configs)

        os.cp("src/*.h", package:installdir("include/openFBX"))
    end)
