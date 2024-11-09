class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runMesonCommand(arguments:  "setup                                          \
                                    --reconfigure                                   \
                                    #{@buildDirectoryNames["MainBuild"]}            \
                                    --prefix=/usr                                   \
                                    --buildtype=release                             \
                                    -Dplatforms=\"\"                                \
                                    -Dgallium-drivers=\"\"                          \
                                    -Dvulkan-drivers=\"\"                           \
                                    -Dinstall-intel-clc=true                        \
                                    -Dintel-clc=enabled                             \
                                    -Dzstd=disabled                                 \
                                    -Dlibunwind=disabled",
                        path:       mainWorkDirectoryPath,
                        environment:    {"PATH" => "/usr/lib/llvm/#{softwareMajorVersion("@ProgrammingLanguages-Main:Llvm")}/bin:$PATH"})
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
