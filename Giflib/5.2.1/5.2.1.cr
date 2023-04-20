class Target < ISM::Software
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(["PREFIX=/usr","DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        deleteFile("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/lib/libgif.a")
        deleteFile("#{buildDirectoryPath(false)}/doc/Makefile")
        deleteAllFilesRecursivelyFinishing("#{buildDirectoryPath(false)}/doc",".1")
        deleteAllFilesRecursivelyFinishing("#{buildDirectoryPath(false)}/doc",".xml")

        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/")

        copyDirectory("#{buildDirectoryPath(false)}/doc","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/giflib-5.2.1")
    end

    def install
        super

        setPermissions("#{Ism.settings.rootPath}usr/share/doc/giflib-5.2.1",0o755)
    end

end
