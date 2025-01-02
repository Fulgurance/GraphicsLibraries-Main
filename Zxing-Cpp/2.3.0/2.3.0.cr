class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end

    def configure
        super

        runCmakeCommand(arguments:      "-DCMAKE_INSTALL_PREFIX=/usr        \
                                        -DCMAKE_BUILD_TYPE=Release          \
                                        -DBUILD_TESTING=OFF                 \
                                        -DBUILD_EXAMPLES=OFF                \
                                        -DBUILD_BLACKBOX_TESTS=OFF          \
                                        -DBUILD_UNIT_TESTS=OFF              \
                                        -B #{buildDirectoryPath}            \
                                        -G Ninja",
                        path:           mainWorkDirectoryPath)
    end

    def build
        super

        runCmakeCommand(arguments:      "--build #{buildDirectoryPath}",
                        path:           mainWorkDirectoryPath)
    end

    def prepareInstallation
        super

        runCmakeCommand(arguments:      "--install #{buildDirectoryPath}",
                        path:           mainWorkDirectoryPath,
                        environment:    {"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
    end

end
