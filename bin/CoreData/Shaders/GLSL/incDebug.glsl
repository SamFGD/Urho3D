#include "inLuminance.glsl"
#include "inGamma.glsl"

const float nonMetallicMin = 50.0/255.0;
const float nonMetallicMax = 243.0/255.0;
const float metallicMin = 186.0/255.0;
const float metallicMax = 255.0/255.0; //Not needed because all values above 186 are valid metallic values

//Color code result nonmetallic correct = red, metallic correct = green
vec3 AlbedoCheck(vec4 iAlbedo, float iMetallic) //, float metallic //return vec4 and check metal values //create 256x256 texture with black and white values to check if this is correct
{
	float luminance = GetLuminance(InvertGamma(iAlbedo.rgb, 2.2)); //Gamma was the problem because the pbr albedo textures where sampled with srgb to linear backbuffer conversion. Se albedo image xml files.
	float nMCheck1 = step(nonMetallicMin, luminance); 
	float nMCheck2 = step(nonMetallicMax, luminance);
	float metallic = step(metallicMin, luminance);
	float nonMetallic = nMCheck1-nMCheck2;
	return vec3(nonMetallic-iMetallic, metallic*iMetallic, 0.0);
}