class Target < ISM::Software
    
    def prepareInstallation
        super

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/include")
        copyDirectory(  path:       "#{mainWorkDirectoryPath}/glm",
                        targetPath: "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/include/")
    end

end
