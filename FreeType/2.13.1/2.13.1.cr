class Target < ISM::Software

    def prepare
        super

        fileReplaceLineContaining(  path:       "#{mainWorkDirectoryPath}modules.cfg",
                                    text:       "# AUX_MODULES += gxvalid",
                                    newLine:    "AUX_MODULES += gxvalid")

        fileReplaceLineContaining(  path:       "#{mainWorkDirectoryPath}modules.cfg",
                                    text:       "# AUX_MODULES += otvalid",
                                    newLine:    "AUX_MODULES += otvalid")

        fileReplaceLineContaining(  path:       "#{mainWorkDirectoryPath}include/freetype/config/ftoption.h",
                                    text:       "/* #define FT_CONFIG_OPTION_SUBPIXEL_RENDERING */",
                                    newLine:    "#define FT_CONFIG_OPTION_SUBPIXEL_RENDERING")
    end
    
    def configure
        super

        configureSource(arguments:  "--prefix=/usr                                                  \
                                    --enable-freetype-config                                        \
                                    #{option("Harfbuzz") ? "--with-harfbuzz" : "--without-harfbuzz"} \
                                    --disable-static",
                        path:       buildDirectoryPath)
    end
    
    def build
        super

        makeSource(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        makeSource( arguments:  "DESTDIR=#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath} install",
                    path:       buildDirectoryPath)
    end

end
