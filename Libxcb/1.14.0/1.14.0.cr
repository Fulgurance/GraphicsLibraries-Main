class Target < ISM::Software
    
    def configure
        super

        configureSource(arguments: ["--prefix=/usr",
                                    "--sysconfdir=/etc",
                                    "--localstatedir=/var",
                                    "--disable-static",
                                    "--without-doxygen",
                                    "--docdir=/usr/share/doc/libxcb-1.14"],
                        path: buildDirectoryPath,
                        environment: {"CFLAGS" => "\"${CFLAGS:--O2 -g} -Wno-error=format-extra-args\"",
                        "PYTHON" => "python3"})
    end
    
    def build
        super

        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
