class Target < ISM::Software

    def prepare
        super

        fileReplaceTextAtLineNumber("#{buildDirectoryPath}docs/faq/Makefile.in","sgml","sgml -o gtk-faq",650)
        fileReplaceTextAtLineNumber("#{buildDirectoryPath}docs/tutorial/Makefile.in","sgml","sgml -o gtk-tut",663)
    end
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--sysconfdir=/etc",
                            "--enable-introspection=#{option("Gobject-Introspection") ? "yes" : "no"}"],
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

        runGtkQueryImmodules2Command(["--update-cache"])
    end

end
