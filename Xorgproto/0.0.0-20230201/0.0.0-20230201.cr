class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

        runMesonCommand(["setup",@buildDirectoryName],mainWorkDirectoryPath)
    end

    def configure
        super

        runMesonCommand([   "configure",
                            @buildDirectoryName,
                            "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--localstatedir=/var",
                            "-Dlegacy=true"],
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
