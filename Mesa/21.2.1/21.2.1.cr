class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end
    
    def configure
        super

        runMesonCommand([   "--prefix=/usr",
                            "--buildtype=release",
                            "-Ddri-drivers=i965,nouveau",
                            "-Dgallium-drivers=crocus,i915,iris,nouveau,r600,radeonsi,svga,swrast,virgl",
                            "-Dgallium-nine=false",
                            "-Dglx=dri",
                            "-Dvalgrind=disabled",
                            "-Dlibunwind=disabled",
                            ".."],
                            buildDirectoryPath)
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
