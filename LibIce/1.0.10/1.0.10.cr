class Target < ISM::Software
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--localstatedir=/var",
                            "--disable-static",
                            "--docdir=/usr/share/doc/libICE-1.0.10",
                            "ICE_LIBS=-lpthread"],
                            buildDirectoryPath)
    end
    
    def build
        super

        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

    def install
        super

        runLdconfigCommand
    end

end
