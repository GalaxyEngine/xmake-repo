package("nazarautils")
    set_kind("static")
    set_homepage("https://github.com/GalaxyEngine/GalaxyMath")
    set_description("Static Math Library for Galaxy Engine")
    set_policy("package.strict_compatibility", true)

    add_urls("https://github.com/GalaxyEngine/GalaxyMath.git")

    add_versions("2023.12.06", "cfa749e1e8ece1bd89d50348b1636ae660bce053")
    
    on_install(function (package)
        import("package.tools.xmake").install(package)
    end)