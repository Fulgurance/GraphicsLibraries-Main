class Target < ISM::Software
    
    def prepareInstallation
        super

        makeDirectory("#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/include")
        copyDirectory("#{mainWorkDirectoryPath}/glm #{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}/usr/include/")
    end

end
