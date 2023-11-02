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
                        environment: {"PYTHON" => "python3"})
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
