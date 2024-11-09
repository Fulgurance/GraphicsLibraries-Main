class Target < ISM::Software

    def prepare
        @buildDirectory = true
        super
    end
    
    def getSelectedGalliumDrivers
        galliumDrivers = String.new

        if option("Gallium-Driver-R300")
            galliumDrivers += "r300,"
        end
        if option("Gallium-Driver-R600")
            galliumDrivers += "r600,"
        end
        if option("Gallium-Driver-Radeonsi")
            galliumDrivers += "radeonsi,"
        end
        if option("Gallium-Driver-Nouveau")
            galliumDrivers += "nouveau,"
        end
        if option("Gallium-Driver-Virgl")
            galliumDrivers += "virgl,"
        end
        if option("Gallium-Driver-Svga")
            galliumDrivers += "svga,"
        end
        if option("Gallium-Driver-Swrast")
            galliumDrivers += "swrast,"
        end
        if option("Gallium-Driver-Iris")
            galliumDrivers += "iris,"
        end
        if option("Gallium-Driver-Crocus")
            galliumDrivers += "crocus,"
        end
        if option("Gallium-Driver-I915")
            galliumDrivers += "i915,"
        end
        if option("Gallium-Driver-Zink")
            galliumDrivers += "zink,"
        end

        return galliumDrivers[0..-2]
    end

    def getSelectedVulkanDrivers
        vulkanDrivers = String.new

        if option("Vulkan-Driver-Amd")
            vulkanDrivers += "amd,"
        end
        if option("Vulkan-Driver-Intel")
            vulkanDrivers += "intel,"
        end
        if option("Vulkan-Driver-Intel-Hasvk")
            vulkanDrivers += "radeonsi,"
        end
        if option("Vulkan-Driver-Nouveau")
            vulkanDrivers += "nouveau,"
        end
        if option("Vulkan-Driver-Swrast")
            vulkanDrivers += "swrast,"
        end

        return vulkanDrivers[0..-2]
    end

    def configure
        super

        galliumDrivers = getSelectedGalliumDrivers
        vulkanDrivers = getSelectedVulkanDrivers

        runMesonCommand(arguments:  "setup                                          \
                                    --reconfigure                                   \
                                    #{@buildDirectoryNames["MainBuild"]}            \
                                    --prefix=/usr                                   \
                                    --buildtype=release                             \
                                    -Dplatforms=x11,wayland                         \
                                    -Degl-native-platform=wayland                   \
                                    -Dgallium-drivers=\"#{galliumDrivers}\"         \
                                    -Dvulkan-drivers=\"#{vulkanDrivers}\"           \
                                    -Dvalgrind=disabled                             \
                                    -Dintel-clc=enabled                             \
                                    -Dlibunwind=disabled",
                        path:       mainWorkDirectoryPath,
                        environment:    {"PATH" => "/usr/lib/llvm/#{softwareMajorVersion("@ProgrammingLanguages-Main:Llvm")}/bin:$PATH"})
    end
    
    def build
        super

        runNinjaCommand(path: buildDirectoryPath)
    end
    
    def prepareInstallation
        super

        runNinjaCommand(arguments:      "install",
                        path:           buildDirectoryPath,
                        environment:    {"DESTDIR" => "#{builtSoftwareDirectoryPath}#{Ism.settings.rootPath}"})
    end

end
