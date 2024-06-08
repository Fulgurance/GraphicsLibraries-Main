class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end
    
    def configure
        super

        runCmakeCommand([   "-DCMAKE_BUILD_TYPE=Release",
                            "-DCMAKE_INSTALL_PREFIX=/usr",
                            "-DTESTDATADIR=$PWD/testfiles",
                            "-DENABLE_LIBOPENJPEG:STRING=#{option("Openjpeg") ? "openjpeg2" : "none"}"
                            "-DENABLE_UNSTABLE_API_ABI_HEADERS=ON",
                            ".."],
                            buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","prefix=/usr","install"],buildDirectoryPath)
    end

end
