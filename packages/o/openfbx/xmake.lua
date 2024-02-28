package("openfbx")
    set_homepage("https://github.com/nem0/OpenFBX")
    set_description("Lightweight open source FBX importer")
    set_license("MIT")

    add_urls("git@github.com:nem0/OpenFBX.git")
    add_versions("2024.02.16", "eefc3df905f762226df980ca95a6c4bac1d0c1ae")

    add_deps("cmake")

    on_install(function (package)
        local configs = {}
        table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:is_debug() and "Debug" or "Release"))
        table.insert(configs, "-DBUILD_SHARED_LIBS=" .. (package:config("shared") and "ON" or "OFF"))
        
        -- Add this line to specify the toolset
        table.insert(configs, "-T host=x64 -A x64")

        import("package.tools.cmake").install(package, configs)
    end)
