class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

        fileReplaceTextAtLineNumber("#{buildDirectoryPath(false)}schemas/org.gnome.system.locale.gschema.xml.in","/system/locale/","/org/gnome/system/locale/",3)
        fileReplaceTextAtLineNumber("#{buildDirectoryPath(false)}schemas/org.gnome.system.proxy.gschema.xml.in","/system/proxy/","/org/gnome/system/proxy/",3)
    end

    def configure
        super

        runMesonCommand([   "--prefix=/usr",
                            "--buildtype=release",
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
    end

    def install
        super

        runGlibCompileSchemasCommand(["#{Ism.settings.rootPath}usr/share/glib-2.0/schemas"])
    end

end
