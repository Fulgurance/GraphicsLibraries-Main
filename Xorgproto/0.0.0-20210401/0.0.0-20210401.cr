class Target < ISM::Software
    
    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runMesonCommand([   "setup",
                            "--reconfigure",
                            "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--localstatedir=/var"
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
