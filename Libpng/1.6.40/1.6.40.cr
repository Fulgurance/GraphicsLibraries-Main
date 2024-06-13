class Target < ISM::Software
    
    def configure
        super

        configureSource(arguments:  "--prefix=/usr  \
                                    --disable-static",
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

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/share/doc/libpng-1.6.40")

        copyFile(   "#{buildDirectoryPath}README",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/share/doc/libpng-1.6.40")

        copyFile(   "#{buildDirectoryPath}libpng-manual.txt",
                    "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/share/doc/libpng-1.6.40")
    end

end
