class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end
    
    def configure
        super

        runMesonCommand([   "--prefix=/usr",
                            "--buildtype=release",
                            "-Ddri-drivers=$DRI_DRIVERS"
                            "-Dgallium-drivers=$GALLIUM_DRV",
                            "-Dgallium-nine=false",
                            "-Dglx=dri",
                            "-Dvalgrind=disabled",
                            "-Dlibunwind=disabled",
                            ".."],
                            buildDirectoryPath)
    end
    
    def build
        super

        runNinjaCommand([] of String,buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        runNinjaCommand(["install"],buildDirectoryPath,{"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
    end

end
