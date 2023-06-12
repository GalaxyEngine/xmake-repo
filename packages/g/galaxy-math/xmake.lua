package("galaxy-math")
    set_kind("static")
    set_homepage("https://github.com/GalaxyEngine/GalaxyMath")
    set_description("Static Math Library for Galaxy Engine")
    set_policy("package.strict_compatibility", true)

    add_urls("https://github.com/GalaxyEngine/GalaxyMath.git")

    add_versions("2023.12.06", "9b8bb998c22038b0f76e9f47f0f743e24d40fcb0")
    
    on_install(function (package)
        import("package.tools.xmake").install(package)
    end)
