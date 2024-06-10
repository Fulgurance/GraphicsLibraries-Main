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

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/libpng-1.6.40")
        copyFile("#{buildDirectoryPath}README","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/libpng-1.6.40")
        copyFile("#{buildDirectoryPath}libpng-manual.txt","#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}usr/share/doc/libpng-1.6.40")
    end

end
