#ifdef D3D11
// Make sampling macros also available for VS on D3D11
#define Sample2D(tex, uv) t##tex.Sample(s##tex, uv)
#define Sample2DProj(tex, uv) t##tex.Sample(s##tex, uv.xy / uv.w)
#define Sample2DLod0(tex, uv) t##tex.SampleLevel(s##tex, uv, 0.0)
#define SampleCube(tex, uv) t##tex.Sample(s##tex, uv)
#define SampleCubeLOD(tex, uv) t##tex.SampleLevel(s##tex, uv.xyz, uv.w)
#define SampleShadow(tex, uv) t##tex.SampleCmpLevelZero(s##tex, uv.xy, uv.z)
#endif

#ifdef COMPILEPS

#ifndef D3D11

// D3D9 samplers
sampler2D s01 : register(s0);
samplerCUBE s01Cube : register(s0);
sampler2D sGBuffer01 : register(s0);
sampler2D s02 : register(s1);
sampler2D sGBuffer02 : register(s1);
sampler2D s03 : register(s2);
sampler2D sGBuffer03 : register(s2);
//sampler2D sRoughMetalFresnel : register(s2); //R: Roughness, G: Metal
sampler2D s04 : register(s3);
sampler2D s05 : register(s4);
samplerCUBE s05Cube : register(s4);
sampler3D s06 : register(s5);
sampler3D s07 : register(s6);
sampler3D s08 : register(s7);
sampler2D sLightRampMap : register(s8);
sampler2D sLightSpotMap : register(s9);
samplerCUBE sLightCubeMap : register(s9);
sampler2D sShadowMap : register(s10);
samplerCUBE sFaceSelectCubeMap : register(s11);
samplerCUBE sIndirectionCubeMap : register(s12);
sampler2D sDepthBuffer : register(s13);
sampler2D sLightBuffer : register(s14);
samplerCUBE sZoneCubeMap : register(s15);
sampler3D sZoneVolumeMap : register(s15);

#define Sample2D(tex, uv) tex2D(s##tex, uv)
#define Sample2DProj(tex, uv) tex2Dproj(s##tex, uv)
#define Sample2DLod0(tex, uv) tex2Dlod(s##tex, float4(uv, 0.0, 0.0))
#define SampleCube(tex, uv) texCUBE(s##tex, uv)
#define SampleCubeLOD(tex, uv) texCUBElod(s##tex, uv)
#define SampleShadow(tex, uv) tex2Dproj(s##tex, uv)

#else

// D3D11 textures and samplers

Texture2D t01 : register(t0);
TextureCube t01Cube : register(t0);
Texture2D tGbuffer01 : register(t0);
Texture2D t02 : register(t1);
Texture2D tGbuffer02 : register(t1);
Texture2D t03 : register(t2);
Texture2D tGbuffer03 : register(t2);
//Texture2D tRoughMetalFresnel : register(t2); //R: Roughness, G: Metal
Texture2D t04 : register(t3);
Texture2D t05 : register(t4);
TextureCube t05Cube : register(t4);
Texture3D t06 : register(t5);
Texture3D t07 : register(t6);
Texture3D t08 : register(t7);
Texture2D tLightRampMap : register(t8);
Texture2D tLightSpotMap : register(t9);
TextureCube tLightCubeMap : register(t9);
Texture2D tShadowMap : register(t10);
TextureCube tFaceSelectCubeMap : register(t11);
TextureCube tIndirectionCubeMap : register(t12);
Texture2D tDepthBuffer : register(t13);
Texture2D tLightBuffer : register(t14);
TextureCube tZoneCubeMap : register(t15);
Texture3D tZoneVolumeMap : register(t15);

SamplerState s01 : register(s0);
SamplerState s01Cube : register(s0);
SamplerState sGbuffer01 : register(s0);
SamplerState s02 : register(s1);
SamplerState sGBuffer02 : register(s1);
SamplerState s03 : register(s2);
//SamplerState sRoughMetalFresnel : register(s2); //R: Roughness, G: Metal 
SamplerState s04 : register(s3);
SamplerState s05 : register(s4);
SamplerState s05Cube : register(s4);
SamplerState s06 : register(s5);
SamplerState s07 : register(s6);
SamplerState s08 : register(s7);
SamplerState sLightRampMap : register(s8);
SamplerState sLightSpotMap : register(s9);
SamplerState sLightCubeMap : register(s9);
#ifdef VSM_SHADOW
    SamplerState sShadowMap : register(s10);
#else
    SamplerComparisonState sShadowMap : register(s10);
#endif
SamplerState sFaceSelectCubeMap : register(s11);
SamplerState sIndirectionCubeMap : register(s12);
SamplerState sDepthBuffer : register(s13);
SamplerState sLightBuffer : register(s14);
SamplerState sZoneCubeMap : register(s15);
SamplerState sZoneVolumeMap : register(s15);

#endif

float3 DecodeNormal(float4 normalInput)
{
#ifdef PACKEDNORMAL
    float3 normal;
    normal.xy = normalInput.ag * 2.0 - 1.0;
    normal.z = sqrt(max(1.0 - dot(normal.xy, normal.xy), 0.0));
    return normal;
#else
    return normalInput.rgb * 2.0 - 1.0;
#endif
}

float ReconstructDepth(float hwDepth)
{
    return dot(float2(hwDepth, cDepthReconstruct.y / (hwDepth - cDepthReconstruct.x)), cDepthReconstruct.zw);
}

#endif
