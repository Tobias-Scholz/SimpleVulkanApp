del "C:\Users\Tobias\source\repos\VulkanEngine\VulkanEngine\shaders\frag.spv"
del "C:\Users\Tobias\source\repos\VulkanEngine\VulkanEngine\shaders\vert.spv"

cd shaders

C:/VulkanSDK/1.1.73.0/Bin32/glslangValidator.exe -V shader.vert
C:/VulkanSDK/1.1.73.0/Bin32/glslangValidator.exe -V shader.frag
pause