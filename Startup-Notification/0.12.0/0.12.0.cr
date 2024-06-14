class Target < ISM::Software
    
    def configure
        super

        configureSource(arguments:  "--prefix=/usr  \
                                    --disable-static",
                        path:       buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(arguments:   "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/startup-notification-0.12")

        copyFile(   "#{buildDirectoryPath}doc/startup-notification.txt",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/startup-notification-0.12/startup-notification.txt")
    end

    def install
        super

        runChmodCommand("0644 /usr/share/doc/startup-notification-0.12/startup-notification.txt")
    end

end
