package("rttr2")
    set_homepage("https://github.com/rttrorg/rttr")
    set_description("C++ Reflection Library")
    add_includedirs("include")

    add_urls("git@github.com:rttrorg/rttr.git")

    add_versions("0.9.6", "v0.9.6")
    add_versions("0.9.5", "v0.9.5")

     on_load(function (package)
        local old_filename = "src/rttr/detail/base/version.h.in"
        local new_filename = "src/rttr/detail/base/version.h"
        if os.isfile(old_filename) then
            os.rename(old_filename, new_filename)
        end
    end)

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.debug", "mode.release")

            -- Runtime mode
            if is_plat("windows") then
                set_runtimes(is_mode("debug") and "MDd" or "MD")
            end

            target("rttr2")
                set_kind("static")

                add_includedirs("src")

                add_files("src/rttr/**.cpp")
                add_headerfiles("src/rttr/**.h")

            target_end()
        ]])
        import("package.tools.xmake").install(package, configs)
    end)
