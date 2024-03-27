package("rttr2")
    set_homepage("https://github.com/rttrorg/rttr")
    set_description("C++ Reflection Library")
    add_includedirs("include")

    add_urls("git@github.com:rttrorg/rttr.git")

    add_versions("0.9.6", "v0.9.6")
    add_versions("0.9.5", "v0.9.5")

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.debug", "mode.release")
            add_rules("plugin.vsxmake.autoupdate")

            -- Runtime mode
            if is_plat("windows") then
                set_runtimes(is_mode("debug") and "MDd" or "MD")
            end

            target("ReflectionTest")
                set_kind("static")

                add_includedirs("src")

                add_files("src/rttr/**.cpp")
                add_headerfiles("src/rttr/**.h")

            target_end()
        ]])
        import("package.tools.xmake").install(package, configs)
    end)
