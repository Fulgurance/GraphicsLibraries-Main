class Target < ISM::Software

    def prepare
        super

        fileReplaceTextAtLineNumber(path:       "#{buildDirectoryPath}docs/faq/Makefile.in",
                                    text:       "sgml",
                                    newText:    "sgml -o gtk-faq",
                                    lineNumber: 650)

        fileReplaceTextAtLineNumber(path:       "#{buildDirectoryPath}docs/tutorial/Makefile.in",
                                    text:       "sgml",
                                    newText:    "sgml -o gtk-tut",
                                    lineNumber: 663)
    end
    
    def configure
        super

        configureSource(arguments:  "--prefix=/usr      \
                                    --sysconfdir=/etc   \
                                    --enable-introspection=#{option("Gobject-Introspection") ? "yes" : "no"}",
                        path:       buildDirectoryPath)
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

        runGtkQueryImmodules2Command("--update-cache")
    end

end
