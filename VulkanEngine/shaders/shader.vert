#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(binding = 0) uniform UniformBufferObject{
	mat4 model;
	mat4 view;
	mat4 proj;
	vec3 lightPosition;
} ubo;

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inColor;
layout(location = 2) in vec3 inNormal;
layout(location = 3) in vec2 inTexCoord;

layout(location = 0) out vec3 fragColor;
layout(location = 1) out vec3 fragNormal;
layout(location = 2) out vec2 fragTexCoord;
layout(location = 3) out vec3 vecToLight;
layout(location = 4) out vec3 vecToCamera;

out gl_PerVertex {
	vec4 gl_Position;
};

void main() {

	gl_Position = ubo.proj * ubo.view * ubo.model * vec4(inPosition.x, inPosition.y, inPosition.z, 1.0);
	vec4 worldPos = ubo.model * vec4(inPosition, 1.0);
	fragColor = inColor;
	fragTexCoord = inTexCoord;
	fragNormal = mat3(ubo.model) * inNormal;
	vecToLight = ubo.lightPosition - vec3(worldPos);
	vecToCamera = (inverse(ubo.view) * vec4(0.f, 0.f, 0.f, 1.f)).xyz - worldPos.xyz;
}