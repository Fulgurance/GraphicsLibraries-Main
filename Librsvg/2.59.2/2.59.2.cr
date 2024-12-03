class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end
    
    def configure
        super

        runMesonCommand(arguments:  "setup --reconfigure    \
                                    --prefix=/usr           \
                                    --buildtype=release     \
                                    -Dman=false",
                        path:       buildDirectoryPath,
                        environment:    {"PATH" => "/usr/lib/llvm/#{softwareMajorVersion("@ProgrammingLanguages-Main:Llvm")}/bin:$PATH"}
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
