class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end
    
    def configure
        super

        runCmakeCommand(arguments:  "-DCMAKE_INSTALL_PREFIX=/usr                                \
                                    -DCMAKE_BUILD_TYPE=RELEASE                                  \
                                    -DENABLE_STATIC=FALSE                                       \
                                    -DCMAKE_INSTALL_DOCDIR=/usr/share/doc/#{versionName}        \
                                    -DCMAKE_INSTALL_DEFAULT_LIBDIR=lib                          \
                                    ..",
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

end
