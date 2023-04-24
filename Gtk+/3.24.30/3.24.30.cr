class Target < ISM::Software
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--enable-broadway-backend",
                            "--enable-x11-backend",
                            "--enable-wayland-backend"],
                            buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

    def install
        super

        runGtkQueryImmodules3Command(["--update-cache"])
        runGlibCompileSchemasCommand(["#{Ism.settings.rootPath}usr/share/glib-2.0/schemas"])
    end

end
