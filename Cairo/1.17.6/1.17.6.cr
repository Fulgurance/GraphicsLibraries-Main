class Target < ISM::Software

    def prepare
        super

        fileReplaceTextAtLineNumber("#{buildDirectoryPath(false)}util/cairo-trace/lookup-symbol.c","PTR","void *",109)
        fileReplaceTextAtLineNumber("#{buildDirectoryPath(false)}util/cairo-trace/lookup-symbol.c","PTR","void *",112)
        fileReplaceTextAtLineNumber("#{buildDirectoryPath(false)}util/cairo-script/cairo-script-interpreter.pc.in","ir@\n","ir@\nexec_prefix=@exec_prefix@\n",2)
    end
    
    def configure
        super

        configureSource([   "--prefix=/usr",
                            "--disable-static",
                            "--enable-tee"],
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
