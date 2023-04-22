class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

        runMesonCommand([   "reconfigure",
                            "..",
                            "-Dinstalled_tests=false"],
                            buildDirectoryPath)
    end
    
    def configure
        super

        runMesonCommand([   "--prefix=/usr",
                            "--buildtype=release",
                            "--wrap-mode=nofallback",
                            "-Dinstalled_tests=false",
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

    def install
        super

        runGdkPixbufQueryLoadersCommand(["--update-cache"])
    end

end
