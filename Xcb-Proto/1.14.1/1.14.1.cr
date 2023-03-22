class Target < ISM::Software
    
    def configure
        super

        configureSource(arguments: ["--prefix=/usr",
                                    "--sysconfdir=/etc",
                                    "--localstatedir=/var",
                                    "--disable-static"],
                        path: buildDirectoryPath,
                        environment: {"PYTHON" => "python3"})
    end

    def prepareInstallation
        super

        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
