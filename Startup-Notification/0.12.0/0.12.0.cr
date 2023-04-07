class Target < ISM::Software
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--disable-static"],
                            buildDirectoryPath)
    end
    
    def build
        super

        makeSource([path: buildDirectoryPath])
    end
    
    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        copyFile("#{buildDirectoryPath(false)}doc/startup-notification.txt","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/startup-notification-0.12/startup-notification.txt")
    end

    def install
        super
        setPermissions("#{Ism.settings.rootPath}usr/share/doc/startup-notification-0.12/startup-notification.txt",0o644)
    end

end
