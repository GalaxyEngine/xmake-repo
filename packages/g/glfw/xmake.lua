package("glfw")

    set_homepage("https://www.glfw.org/")
    set_description("GLFW is an Open Source, multi-platform library for OpenGL, OpenGL ES and Vulkan application development.")
    set_license("zlib")
    add_includedirs("include", "include/GLFW")

    add_urls("https://github.com/glfw/glfw/archive/refs/tags/$(version).tar.gz",
             "https://github.com/glfw/glfw.git")
    add_versions("3.4-galaxy", "c038d34200234d071fae9345bc455e4a8f2f544ab60150765d7704e08f3dac01")

    add_configs("glfw_include", {description = "Choose submodules enabled in glfw", default = "none", type = "string", values = {"none", "vulkan", "glu", "glext", "es2", "es3"}})

    if is_plat("linux") then
        add_extsources("apt::libglfw3-dev", "pacman::glfw-x11")
    end

    add_deps("cmake")
    add_deps("opengl", {optional = true})
    if is_plat("macosx") then
        add_frameworks("Cocoa", "IOKit")
    elseif is_plat("windows") then
        add_syslinks("user32", "shell32", "gdi32")
    elseif is_plat("mingw") then
        add_syslinks("gdi32")
    elseif is_plat("linux") then
        -- TODO: add wayland support
        add_deps("libx11", "libxrandr", "libxrender", "libxinerama", "libxfixes", "libxcursor", "libxi", "libxext")
        add_syslinks("dl", "pthread")
        add_defines("_GLFW_X11")
    end

    on_load(function (package)
        package:add("defines", "GLFW_INCLUDE_" .. package:config("glfw_include"):upper())
    end)

    on_install(function (package)
        local configs = {}
        io.writefile("xmake.lua", [[
            add_rules("mode.debug", "mode.release")

            if is_plat("windows") then
                set_runtimes(is_mode("debug") and "MDd" or "MD")
            end

            target("glfw")
                set_kind("static")
                set_targetdir("$(projectdir)/build") -- Output directory for the compiled library

                -- Add include directories
                add_includedirs("include")

                -- Add source files
                add_files("src/**.c")
                -- Add platform-specific source files
                if is_plat("windows") then
                    add_defines("_GLFW_WIN32")
                elseif is_plat("macosx") then
                    add_defines("_GLFW_COCOA")
                    add_files("src/**.m")
                elseif is_plat("linux") then
                    add_defines("_GLFW_X11")
                    -- Add required libraries for Linux
                    add_syslinks("dl", "pthread", "GL", "X11")
                end
            target_end()
        ]])
        import("package.tools.xmake").install(package, configs)

        os.cp("include/GLFW/*.h", package:installdir("include/GLFW"))
    end)

    on_test(function (package)
        assert(package:check_csnippets({test = [[
            void test() {
                glfwInit();
                glfwTerminate();
            }
        ]]}, {configs = {languages = "c11"}, includes = "GLFW/glfw3.h"}))
    end)