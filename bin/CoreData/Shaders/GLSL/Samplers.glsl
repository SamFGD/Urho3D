#ifdef COMPILEPS
#ifdef CUBE01
	uniform samplerCube sTextureUnit1;
#elif TEX3D01
	uniform sampler3D sTextureUnit1;
#else
	uniform sampler2D sTextureUnit1; //TEX2D01 inside shader if it is using a texture
#endif
#ifdef CUBE02
	uniform samplerCube sTextureUnit2;
#elif TEX3D02
	uniform sampler3D sTextureUnit2;
#else
	uniform sampler2D sTextureUnit2;
#endif
#ifdef CUBE03
	uniform samplerCube sTextureUnit3;
#elif TEX3D03
	uniform sampler3D sTextureUnit3;
#else
	uniform sampler2D sTextureUnit3;
#endif
#ifdef CUBE04
	uniform samplerCube sTextureUnit4;
#elif TEX3D04
	uniform sampler3D sTextureUnit4;
#else
	uniform sampler2D sTextureUnit4;
#endif
#ifdef CUBE05
	uniform samplerCube sTextureUnit5;
#elif TEX3D05
	uniform sampler3D sTextureUnit5;
#else
	uniform sampler2D sTextureUnit5;
#endif
uniform sampler2D sLightRampMap;
uniform sampler2D sLightSpotMap;
uniform samplerCube sLightCubeMap;
#ifndef GL_ES
    uniform sampler2D sGBuffer01;
    uniform sampler2D sGBuffer02;
    uniform sampler2D sGBuffer03;
	#ifdef CUBE06
		uniform samplerCube sTextureUnit6;
	#elif TEX3D06
		uniform sampler3D sTextureUnit6;
	#else
		uniform sampler2D sTextureUnit6;
	#endif
	#ifdef CUBE07
		uniform samplerCube sTextureUnit7;
	#elif TEX3D07
		uniform sampler3D sTextureUnit7;
	#else
		uniform sampler2D sTextureUnit7;
	#endif
	#ifdef CUBE08
		uniform samplerCube sTextureUnit8;
	#elif TEX3D08
		uniform sampler3D sTextureUnit8;
	#else
		uniform sampler2D sTextureUnit8;
	#endif
    uniform sampler2D sDepthBuffer;
    uniform sampler2D sLightBuffer;
    #ifdef VSM_SHADOW
        uniform sampler2D sShadowMap;
    #else
        uniform sampler2DShadow sShadowMap;
    #endif
    uniform samplerCube sFaceSelectCubeMap;
    uniform samplerCube sIndirectionCubeMap;
    uniform samplerCube sZoneCubeMap;
    uniform sampler3D sZoneVolumeMap;
#else
    uniform highp sampler2D sShadowMap;
#endif

#ifdef GL3
#define texture2D texture
#define texture2DProj textureProj
#define texture3D texture
#define textureCube texture
#define texture2DLod textureLod
#define texture2DLodOffset textureLodOffset
#endif

vec3 DecodeNormal(vec4 normalInput)
{
    #ifdef PACKEDNORMAL
        vec3 normal;
        normal.xy = normalInput.ag * 2.0 - 1.0;
        normal.z = sqrt(max(1.0 - dot(normal.xy, normal.xy), 0.0));
        return normal;
    #else
        return normalize(normalInput.rgb * 2.0 - 1.0);
    #endif
}

vec3 EncodeDepth(float depth)
{
    #ifndef GL3
        vec3 ret;
        depth *= 255.0;
        ret.x = floor(depth);
        depth = (depth - ret.x) * 255.0;
        ret.y = floor(depth);
        ret.z = (depth - ret.y);
        ret.xy *= 1.0 / 255.0;
        return ret;
    #else
        // OpenGL 3 can use different MRT formats, so no need for encoding
        return vec3(depth, 0.0, 0.0);
    #endif
}

float DecodeDepth(vec3 depth)
{
    #ifndef GL3
        const vec3 dotValues = vec3(1.0, 1.0 / 255.0, 1.0 / (255.0 * 255.0));
        return dot(depth, dotValues);
    #else
        // OpenGL 3 can use different MRT formats, so no need for encoding
        return depth.r;
    #endif
}

float ReconstructDepth(float hwDepth)
{
    return dot(vec2(hwDepth, cDepthReconstruct.y / (hwDepth - cDepthReconstruct.x)), cDepthReconstruct.zw);
}
#endif
