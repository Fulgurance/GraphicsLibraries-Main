class Target < ISM::Software
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource( arguments:  "PREFIX=/usr DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)

        deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/lib/libgif.a")
        deleteFile("#{buildDirectoryPath}/doc/Makefile")

        deleteAllFilesRecursivelyFinishing( path:       "#{buildDirectoryPath}/doc",
                                            extensions: ["1","xml"])

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/")

        copyDirectory(  "#{buildDirectoryPath}/doc",
                        "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/giflib-5.2.1")
    end

    def install
        super

        runChmodCommand("0755 /usr/share/doc/giflib-5.2.1")
    end

end
