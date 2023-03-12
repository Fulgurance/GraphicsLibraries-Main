class Target < ISM::Software

    def prepare
        super

        fileReplaceLineContaining("#{mainWorkDirectoryPath(false)}modules.cfg","# AUX_MODULES += gxvalid","AUX_MODULES += gxvalid")
        fileReplaceLineContaining("#{mainWorkDirectoryPath(false)}modules.cfg","# AUX_MODULES += otvalid","AUX_MODULES += otvalid")
        fileReplaceLineContaining("#{mainWorkDirectoryPath(false)}include/freetype/config/ftoption.h","/* #define FT_CONFIG_OPTION_SUBPIXEL_RENDERING */","#define FT_CONFIG_OPTION_SUBPIXEL_RENDERING")
    end
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--enable-freetype-config",
                            "--disable-static"],
                            buildDirectoryPath)
    end
    
    def build
        super

        makeSource([Ism.settings.makeOptions],buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource([Ism.settings.makeOptions,"DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}","install"],buildDirectoryPath)
    end

end
