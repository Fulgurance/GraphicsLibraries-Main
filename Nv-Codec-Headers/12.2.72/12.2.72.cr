class Target < ISM::Software
    
    def build
        super

        makeSource( arguments:  "PREFIX=/usr -C nv-codec-headers",
                    path:       buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} -C nv-codec-headers install",
                    path:       buildDirectoryPath)
    end

    def install
        super

        runLdconfigCommand
    end

end
