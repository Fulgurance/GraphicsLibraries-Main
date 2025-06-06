class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runMesonCommand(arguments:  "setup                                                                          \
                                    --reconfigure                                                                   \
                                    #{@buildDirectoryNames["MainBuild"]}                                            \
                                    --prefix=/usr                                                                   \
                                    --buildtype=release                                                             \
                                    --wrap-mode=nofallback                                                          \
                                    -Dbuild-examples=false                                                          \
                                    -Dcairo=#{option("Cairo") ? "enabled" : "disabled"}                             \
                                    -Dlibthai=#{option("Libthai") ? "enabled" : "disabled"}                             \
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
