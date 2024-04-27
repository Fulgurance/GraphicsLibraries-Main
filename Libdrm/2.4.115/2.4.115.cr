class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end
    
    def configure
        super

        runMesonCommand([   "setup",
                            "--reconfigure",
                            "-Dauto_features=disabled",
                            "--prefix=/usr",
                            "--buildtype=release",
                            "-Dudev=true",
                            "-Dvalgrind=disabled"],
                            buildDirectoryPath)
    end
    
    def build
        super

        runNinjaCommand([] of String,buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        runNinjaCommand(["install"],buildDirectoryPath,{"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
    end

end
