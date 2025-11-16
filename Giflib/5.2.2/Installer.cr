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
    end

end
