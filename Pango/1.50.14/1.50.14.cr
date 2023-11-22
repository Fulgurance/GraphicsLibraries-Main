class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

        fileDeleteLine("#{mainWorkDirectoryPath(false)}meson.build",92)
        fileDeleteLine("#{mainWorkDirectoryPath(false)}meson.build",134)

        runMesonCommand(["setup",@buildDirectoryName],mainWorkDirectoryPath)
    end

    def configure
        super

        runMesonCommand([   "configure",
                            @buildDirectoryName,
                            "--prefix=/usr",
                            "--buildtype=release",
                            "--wrap-mode=nofallback"],
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
