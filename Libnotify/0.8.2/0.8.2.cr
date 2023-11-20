class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

    end

    def configure
        super

        runMesonCommand([   "--prefix=/usr",
                            "--buildtype=release",
                            "-Dgtk_doc=false",
                            "-Dman=false",
                            ".."],
                            buildDirectoryPath)
    end

    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        runNinjaCommand(["install"],buildDirectoryPath,{"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
        moveFile("#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/share/doc/libnotify","#{builtSoftwareDirectoryPath(false)}#{Ism.settings.rootPath}/usr/share/doc/libnotify-0.8.2")
    end

end
