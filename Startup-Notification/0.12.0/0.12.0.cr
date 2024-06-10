class Target < ISM::Software
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--disable-static"],
                            buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/startup-notification-0.12")
        copyFile("#{buildDirectoryPath}doc/startup-notification.txt","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/startup-notification-0.12/startup-notification.txt")
    end

    def install
        super

        runChmodCommand(["0644","/usr/share/doc/startup-notification-0.12/startup-notification.txt"])
    end

end
