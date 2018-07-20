#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(binding = 0) uniform UniformBufferObject{
	mat4 model;
	mat4 view;
	mat4 proj;
	vec3 lightPosition;
} ubo;

layout(binding = 1) uniform sampler2D texSampler;

layout(location = 0) in vec3 fragColor;
layout(location = 1) in vec3 fragNormal;
layout(location = 2) in vec2 fragTexCoord;
layout(location = 3) in vec3 vecToLight;
layout(location = 4) in vec3 vecToCamera;

layout(location = 0) out vec4 outColor;

float lightIntens = 14.f;
float shineDamper = 20.f;

float getBrightness(float distance)
{
	return clamp(-(1/lightIntens) * distance + 1, 0.f, 1.f);
}

void main() 
{
	float brightness = dot(normalize(vecToLight), normalize(fragNormal));
	brightness = clamp(brightness * getBrightness(length(vecToLight)), 0.05, 1.0);

	vec3 lightDir = -(normalize(vecToLight));
	vec3 reflectedLightDirection = reflect(lightDir, normalize(fragNormal));

	float specularFactor = dot(reflectedLightDirection, normalize(vecToCamera));
	specularFactor = clamp(specularFactor, 0.0, 1.0);
	float dampedFactor = pow(specularFactor, shineDamper);

    outColor = texture(texSampler, fragTexCoord) * brightness + vec4(dampedFactor, dampedFactor, dampedFactor, 1.0);
}