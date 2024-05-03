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
                            "--wrap-mode=nofallback",
                            "-Dman=false"],
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

        runGdkPixbufQueryLoadersCommand(["--update-cache"])
    end

end
