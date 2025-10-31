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
                                    -Dintrospection=#{option("Gobject-Introspection") ? "enabled" : "disabled"} ",
                        path:       buildDirectoryPath)
    end
    
    def build
        super

        usingGlibc = component("C-Library").uniqueDependencyIsEnabled("@ProgrammingTools-Main:Glibc")

        runNinjaCommand(path: buildDirectoryPath,
                        environment:    {"RUSTFLAGS" => (usingGlibc ? "" : "-C target-feature=-crt-static")})
    end
    
    def prepareInstallation
        super

        runNinjaCommand(arguments:      "install",
                        path:           buildDirectoryPath,
                        environment:    {"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
    end

end
