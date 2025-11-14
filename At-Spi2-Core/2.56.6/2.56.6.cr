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
                                    -Dsystemd_user_dir=/tmp \
                                    -Dintrospection=#{option("Gobject-Introspection") ? "enabled" : "disabled"} \
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

        deleteFile("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/tmp/at-spi-dbus-bus.service")
    end

end
