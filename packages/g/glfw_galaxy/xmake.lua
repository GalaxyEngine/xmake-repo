package("glfw_galaxy")

    set_homepage("https://www.glfw.org/")
    set_description("GLFW is an Open Source, multi-platform library for OpenGL, OpenGL ES and Vulkan application development.")
    set_license("zlib")
    add_includedirs("include", "include/GLFW")

    add_urls("https://github.com/glfw/glfw/archive/refs/tags/$(version).tar.gz",
             "https://github.com/glfw/glfw.git")
    add_versions("3.3.2", "98768e12e615fbe9f3386f5bbfeb91b5a3b45a8c4c77159cef06b1f6ff749537")
    add_versions("3.3.4", "cc8ac1d024a0de5fd6f68c4133af77e1918261396319c24fd697775a6bc93b63")
    add_versions("3.3.5", "32fdb8705784adfe3082f97e0d41e7c515963e977b5a14c467a887cf0da827b5")
    add_versions("3.3.6", "ed07b90e334dcd39903e6288d90fa1ae0cf2d2119fec516cf743a0a404527c02")
    add_versions("3.3.7", "fd21a5f65bcc0fc3c76e0f8865776e852de09ef6fbc3620e09ce96d2b2807e04")
    add_versions("3.3.8", "f30f42e05f11e5fc62483e513b0488d5bceeab7d9c5da0ffe2252ad81816c713")
    add_versions("3.3.9", "a7e7faef424fcb5f83d8faecf9d697a338da7f7a906fc1afbc0e1879ef31bd53")
    add_versions("3.4", "c038d34200234d071fae9345bc455e4a8f2f544ab60150765d7704e08f3dac01")

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

        if (not is_plat("windows")) then
            package:add("defines", "GLFW_INCLUDE_" .. package:config("glfw_include"):upper())
            if package:config("x11") then
                package:add("deps", "libx11", "libxrandr", "libxrender", "libxinerama", "libxfixes", "libxcursor", "libxi", "libxext")
            end
            if package:config("wayland") then
                package:add("deps", "wayland")
            end
        end


    end)

    on_install(function (package)
        if (is_plat("windows")) then
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
        else
            local configs = {"-DGLFW_BUILD_DOCS=OFF", "-DGLFW_BUILD_TESTS=OFF", "-DGLFW_BUILD_EXAMPLES=OFF"}
            table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:debug() and "Debug" or "Release"))
            table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
            if package:is_plat("windows") then
                table.insert(configs, "-DUSE_MSVC_RUNTIME_LIBRARY_DLL=" .. (package:config("vs_runtime"):startswith("MT") and "OFF" or "ON"))
            end
            table.insert(configs, "-DGLFW_BUILD_X11=" .. (package:config("x11") and "ON" or "OFF"))
            table.insert(configs, "-DGLFW_BUILD_WAYLAND=" .. (package:config("wayland") and "ON" or "OFF"))
            if package:is_plat("linux") then
                import("package.tools.cmake").install(package, configs, {packagedeps = {"libxrender", "libxfixes", "libxext", "libx11", "wayland"}})
            else
                import("package.tools.cmake").install(package, configs)
            end
        end
    end)

    on_test(function (package)
        assert(package:check_csnippets({test = [[
            void test() {
                glfwInit();
                glfwTerminate();
            }
        ]]}, {configs = {languages = "c11"}, includes = "GLFW/glfw3.h"}))
    end)
