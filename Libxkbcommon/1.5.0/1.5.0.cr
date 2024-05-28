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
                            "-Denable-x11=#{option("Libxcb") ? "true" : "false"}",
                            "-Denable-wayland=#{option("Wayland") ? "true" : "false"}",
                            "-Denable-docs=false"],
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

end
