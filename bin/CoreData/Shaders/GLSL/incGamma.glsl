const float Gamma = 2.2;
const float InverseGamma = 1.0 / 2.2;

vec3 ToGamma2(vec3 color)
{
    //return vec3(pow(color.r, Gamma), pow(color.g, Gamma), pow(color.b, Gamma));
	return vec3(pow(color.rgb, vec3(Gamma, Gamma, Gamma)));
}
vec3 ToInverseGamma2(vec3 color)
{
    //return vec3(pow(color.r, InverseGamma), pow(color.g, InverseGamma), pow(color.b, InverseGamma));
	return vec3(pow(color.rgb, vec3(InverseGamma, InverseGamma, InverseGamma)));
}
vec3 ApplyGamma(vec3 color, float gamma) //Gamma should be set by application
{
	return vec3(pow(color, vec3(gamma, gamma, gamma)));
}
vec3 InvertGamma(vec3 color, float gamma)
{
	return vec3(pow(color, vec3(1.0/gamma, 1.0/gamma, 1.0/gamma)));
}
//Gamma is applied to textures on import or automatically in the png file which means I need to invert the gamma to get "correct" perceived luminance.
//Apply inverse gamma to metalness and roughness maps. Normalmaps probably also require inverse gamma because they should be linear values.
//Maps which need linear values before final output probably require inverse gamma
//Check albedo xml files because pbr albedo textures are sampled with srgb.

//Clamp all division by zero values. min(X=0.00001(M_EPSILON=0.0001), Y=value) Y<X? Y; X;