package("galaxyheadertool")
    set_kind("binary")
    set_homepage("https://github.com/GalaxyEngine/GalaxyHeaderTool")
    set_description("Header tool for the engine GalaxyEngine")

    add_urls("https://github.com/GalaxyEngine/GalaxyHeaderTool.git")

    add_versions("1.0", "6e5301ef150d4c929b082ac9f61693acc380192a")
    add_versions("1.0-galaxyengine", "0ae2441b96ea24df16353340c2bfce447885fb7c")

    add_configs("destdir", { 
        description = "The destination directory where the binary will be copied. If not set, the binary is copied to the project root.",
        default = "", -- this default is used only if the config is not nil
        type = "string"
    })

    on_install(function (package)
        import("package.tools.xmake").install(package)

        local binfile_exe = path.join(package:installdir("bin"), "GalaxyHeaderTool.exe")
        local binfile_default = path.join(package:installdir("bin"), "GalaxyHeaderTool")
        local binfile = nil

        if os.isfile(binfile_exe) then
            binfile = binfile_exe
        elseif os.isfile(binfile_default) then
            binfile = binfile_default
        else
            raise("Binary not found!")
        end

        -- Retrieve the destination directory from config.
        local destdir = package:config("destdir")
        print("Destination directory is " .. destdir)
        if destdir == nil or destdir == "" then
            -- If destdir is nil or empty, copy the binary to the project root.
            destdir = os.projectdir()
        else
            -- Otherwise, make the path absolute relative to the project directory.
            destdir = path.absolute(destdir, os.projectdir())
            os.mkdir(destdir)
        end

        os.cp(binfile, destdir)
    end)
