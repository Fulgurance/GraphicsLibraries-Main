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
                                        -DENABLE_CXX11=ON                   \
                                        -DBUILD_PERF_TESTS=OFF              \
                                        -DWITH_XINE=OFF                     \
                                        -DBUILD_TESTS=OFF                   \
                                        -DENABLE_PRECOMPILED_HEADERS=OFF    \
                                        -DCMAKE_SKIP_INSTALL_RPATH=ON       \
                                        -DBUILD_WITH_DEBUG_INFO=OFF         \
                                        -W no-dev                           \
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
