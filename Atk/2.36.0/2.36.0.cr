class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

        runMesonCommand([   "reconfigure",
                            "..",
                            option("Gobject-Introspection") ? "-Dintrospection=true" : "-Dintrospection=false"],
                            buildDirectoryPath)
    end
    
    def configure
        super

        runMesonCommand([   "--prefix=/usr",
                            "--buildtype=release",
                            option("Gobject-Introspection") ? "-Dintrospection=true" : "-Dintrospection=false",
                            ".."],
                            buildDirectoryPath)
    end
    
    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        runNinjaCommand(["install"],buildDirectoryPath,{"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
    end

end
