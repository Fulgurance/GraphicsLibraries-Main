class Target < ISM::Software

    def prepare
        super

        fileReplaceTextAtLineNumber(path:       "#{buildDirectoryPath}util/cairo-trace/lookup-symbol.c",
                                    text:       "PTR",
                                    newText:    "void *",
                                    lineNumber: 109)

        fileReplaceTextAtLineNumber(path:       "#{buildDirectoryPath}util/cairo-trace/lookup-symbol.c",
                                    text:       "PTR",
                                    newText:    "void *",
                                    lineNumber: 112)

        fileReplaceTextAtLineNumber(path:       "#{buildDirectoryPath}util/cairo-script/cairo-script-interpreter.pc.in",
                                    text:       "ir@\n",
                                    newText:    "ir@\nexec_prefix=@exec_prefix@\n",
                                    lineNumber: 2)
    end
    
    def configure
        super

        configureSource(arguments:  "--prefix=/usr      \
                                    --disable-static    \
                                    --enable-tee",
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
