class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end
    
    def configure
        super

        runCmakeCommand(arguments:  "-DCMAKE_BUILD_TYPE=Release \
                                    -DCMAKE_INSTALL_PREFIX=/usr \
                                    -DENABLE_OPT=0              \
                                    ..",
                        path:       buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} prefix=/usr install",
                    path:       buildDirectoryPath)
    end

end
