class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

        fileReplaceTextAtLineNumber(path:       "#{mainWorkDirectoryPath}/schemas/org.gnome.system.locale.gschema.xml.in",
                                    text:       "/system/locale/",
                                    newText:    "/org/gnome/system/locale/",
                                    lineNumber: 3)
        fileReplaceTextAtLineNumber(path:       "#{mainWorkDirectoryPath}/schemas/org.gnome.system.proxy.gschema.xml.in",
                                    text:       "/system/proxy/",
                                    newText:    "/org/gnome/system/proxy/",
                                    lineNumber: 3)
    end

    def configure
        super

        runMesonCommand(arguments:  "setup --reconfigure    \
                                    --prefix=/usr           \
                                    --buildtype=release     \
                                    ..",
                        path:       buildDirectoryPath)
    end

    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end

    def prepareInstallation
        super

        runNinjaCommand(arguments:      "install",
                        path:           buildDirectoryPath,
                        environment:    {"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
    end

    def install
        super

        runGlibCompileSchemasCommand("/usr/share/glib-2.0/schemas")
    end

end
