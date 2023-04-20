class Target < ISM::Software

    def prepare
        @buildDirectoryPath = true
        super
    end
    
    def configure
        super

        runMesonCommand([   "--prefix=/usr",
                            "--buildtype=release",
                            option("Gobject-Introspection") ? "Dinstrospection=true" : "Dinstrospection=false",
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
