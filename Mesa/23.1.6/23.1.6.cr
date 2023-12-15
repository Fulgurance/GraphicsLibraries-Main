class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super

        runMesonCommand(["setup",@buildDirectoryNames["MainBuild"]],mainWorkDirectoryPath)
    end
    
    def configure
        super

        runMesonCommand([   "configure",
                            @buildDirectoryNames["MainBuild"],
                            "--prefix=/usr",
                            "--buildtype=release",
                            "-Dplatforms=x11,wayland",
                            "-Ddri-drivers=auto",
                            "-Dgallium-drivers=auto",
                            "-Dvulkan-drivers=\"\"",
                            "-Dvalgrind=disabled",
                            "-Dlibunwind=disabled"],
                            mainWorkDirectoryPath)
    end
    
    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        runNinjaCommand(["install"],buildDirectoryPath,{"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
    end

end
