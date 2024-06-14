class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end
    
    def configure
        super

        runMesonCommand(arguments:  "setup                                  \
                                    --reconfigure                           \
                                    #{@buildDirectoryNames["MainBuild"]}    \
                                    --prefix=/usr                           \
                                    --buildtype=release                     \
                                    -Dplatforms=x11,wayland                 \
                                    -Degl-native-platform=wayland           \
                                    -Dgallium-drivers=auto                  \
                                    -Dvulkan-drivers=\"\"                   \
                                    -Dvalgrind=disabled                     \
                                    -Dlibunwind=disabled",
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
