class Target < ISM::Software
    
    def configure
        super

        configureSource(arguments:  "--prefix=/usr          \
                                    --sysconfdir=/etc       \
                                    --localstatedir=/var    \
                                    --disable-static        \
                                    --docdir=/usr/share/doc/libXvMC-1.0.13",
                                    buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)
    end

    def install
        super

        runLdconfigCommand
    end

end
