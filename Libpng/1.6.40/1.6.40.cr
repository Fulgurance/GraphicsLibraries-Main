class Target < ISM::Software
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--disable-static"],
                            buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)

        makeDirectory("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/libpng-1.6.40")
        copyFile("#{buildDirectoryPath(false)}README","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/libpng-1.6.40")
        copyFile("#{buildDirectoryPath(false)}libpng-manual.txt","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}usr/share/doc/libpng-1.6.40")
    end

end
