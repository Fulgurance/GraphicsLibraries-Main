class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

        fileDeleteLine("#{mainWorkDirectoryPath}meson.build",92)
        fileDeleteLine("#{mainWorkDirectoryPath}meson.build",134)
    end

    def configure
        super

        runMesonCommand(arguments:  "setup                                                                          \
                                    --reconfigure                                                                   \
                                    #{@buildDirectoryNames["MainBuild"]}                                            \
                                    --prefix=/usr                                                                   \
                                    --buildtype=release                                                             \
                                    --wrap-mode=nofallback                                                          \
                                    -Dintrospection=#{option("Gobject-Instrospection") ? "enabled" : "disabled"}",
                        path:       mainWorkDirectoryPath)
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

end
