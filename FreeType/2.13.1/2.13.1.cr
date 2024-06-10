class Target < ISM::Software

    def prepare
        super

        fileReplaceLineContaining("#{mainWorkDirectoryPath}modules.cfg","# AUX_MODULES += gxvalid","AUX_MODULES += gxvalid")
        fileReplaceLineContaining("#{mainWorkDirectoryPath}modules.cfg","# AUX_MODULES += otvalid","AUX_MODULES += otvalid")
        fileReplaceLineContaining("#{mainWorkDirectoryPath}include/freetype/config/ftoption.h","/* #define FT_CONFIG_OPTION_SUBPIXEL_RENDERING */","#define FT_CONFIG_OPTION_SUBPIXEL_RENDERING")
    end
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--enable-freetype-config",
                            option("Harfbuzz") ? "--with-harfbuzz" : "--without-harfbuzz",
                            "--disable-static"],
                            buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource(["DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
