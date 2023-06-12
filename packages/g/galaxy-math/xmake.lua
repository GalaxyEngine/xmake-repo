package("galaxy-math")
    set_kind("static")
    set_homepage("https://github.com/GalaxyEngine/GalaxyMath")
    set_description("Static Math Library for Galaxy Engine")
    set_policy("package.strict_compatibility", true)

    add_urls("https://github.com/GalaxyEngine/GalaxyMath.git")

    add_includedirs("include")

    add_versions("v2", "e28aaf09654d78acd61f1a6a9864b6cf482fa550")
    
    on_install(function (package)
        import("package.tools.xmake").install(package)
    end)
