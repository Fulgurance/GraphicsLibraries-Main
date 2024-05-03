class Target < ISM::Software
    
    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runMesonCommand([   "setup",
                            "--reconfigure",
                            @buildDirectoryNames["MainBuild"],
                            "--prefix=/usr",
                            "--buildtype=release",
                            "-Dintrospection=#{option("Gobject-Introspection") ? "true" : "false"}",
                            "-Dman=true",
                            "-Dbroadway_backend=true"],
                            mainWorkDirectoryPath)
    end

    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        runNinjaCommand(["install"],buildDirectoryPath,{"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
    end

    def install
        super

        runGtkQueryImmodules3Command(["--update-cache"])
        runGlibCompileSchemasCommand(["/usr/share/glib-2.0/schemas"])
    end

end
