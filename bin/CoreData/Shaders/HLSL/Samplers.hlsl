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
#ifdef CUBE01
samplerCUBE sTextureUnit1 : register(s0);
#elif TEX3D01
sampler3D sTextureUnit1 : register(s0);
#else
sampler2D sTextureUnit1 : register(s0);
#endif
#ifdef CUBE02
samplerCUBE sTextureUnit2 : register(s1);
#elif TEX3D02
sampler3D sTextureUnit2 : register(s1);
#else
sampler2D sTextureUnit2 : register(s1);
#endif
#ifdef CUBE03
samplerCUBE sTextureUnit3 : register(s2);
#elif TEX3D03
sampler3D sTextureUnit3 : register(s2);
#else
sampler2D sTextureUnit3 : register(s2);
#endif
#ifdef CUBE04
samplerCUBE sTextureUnit4 : register(s3);
#elif TEX3D04
sampler3D sTextureUnit4 : register(s3);
#else
sampler2D sTextureUnit4 : register(s3);
#endif
#ifdef CUBE05
samplerCUBE sTextureUnit5 : register(s4);
#elif TEX3D05
sampler3D sTextureUnit5 : register(s4);
#else
sampler2D sTextureUnit5 : register(s4);
#endif
#ifdef CUBE06
samplerCUBE sTextureUnit6 : register(s5);
#elif TEX3D06
sampler3D sTextureUnit6 : register(s5);
#else
sampler2D sTextureUnit6 : register(s5);
#endif
#ifdef CUBE07
samplerCUBE sTextureUnit7 : register(s6);
#elif TEX3D07
sampler3D sTextureUnit7 : register(s6);
#else
sampler2D sTextureUnit7 : register(s6);
#endif
#ifdef CUBE08
samplerCUBE sTextureUnit8 : register(s7);
#elif TEX3D08
sampler3D sTextureUnit8 : register(s7);
#else
sampler2D sTextureUnit8 : register(s7);
#endif
sampler2D sGBuffer01 : register(s0);
sampler2D sGBuffer02 : register(s1);
sampler2D sGBuffer03 : register(s2);
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
#ifdef CUBE01
TextureCube tTextureUnit1 : register(t0);
#elif TEX3D01
Texture3D tTextureUnit1 : register(t0);
#else
Texture2D tTextureUnit1 : register(t0);
#endif
#ifdef CUBE02
TextureCube tTextureUnit2 : register(t1);
#elif TEX3D02
Texture3D tTextureUnit2 : register(t1);
#else
Texture2D tTextureUnit2 : register(t1);
#endif
#ifdef CUBE03
TextureCube tTextureUnit3 : register(t2);
#elif TEX3D03
Texture3D tTextureUnit3 : register(t2);
#else
Texture2D tTextureUnit3 : register(t2);
#endif
#ifdef CUBE04
TextureCube tTextureUnit4 : register(t3);
#elif TEX3D04
Texture3D tTextureUnit4 : register(t3);
#else
Texture2D tTextureUnit4 : register(t3);
#endif
#ifdef CUBE05
TextureCube tTextureUnit5 : register(t4);
#elif TEX3D05
Texture3D tTextureUnit5 : register(t4);
#else
Texture2D tTextureUnit5 : register(t4);
#endif
#ifdef CUBE06
TextureCube tTextureUnit6 : register(t5);
#elif TEX3D06
Texture3D tTextureUnit6 : register(t5);
#else
Texture2D tTextureUnit6 : register(t5);
#endif
#ifdef CUBE07
TextureCube tTextureUnit7 : register(t6);
#elif TEX3D07
Texture3D tTextureUnit7 : register(t6);
#else
Texture2D tTextureUnit7 : register(t6);
#endif
#ifdef CUBE08
TextureCube tTextureUnit8 : register(t7);
#elif TEX3D08
Texture3D tTextureUnit8 : register(t7);
#else
Texture2D tTextureUnit8 : register(t7);
#endif

Texture2D tGBuffer01 : register(t0);
Texture2D tGBuffer02 : register(t1);
Texture2D tGBuffer03 : register(t2);
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

SamplerState sTextureUnit1 : register(s0);
SamplerState sTextureUnit2 : register(s1);
SamplerState sTextureUnit3 : register(s2);
SamplerState sTextureUnit4 : register(s3);
SamplerState sTextureUnit5 : register(s4);
SamplerState sTextureUnit6 : register(s5);
SamplerState sTextureUnit7 : register(s6);
SamplerState sTextureUnit8 : register(s7);
SamplerState sGBuffer01 : register(s0);
SamplerState sGBuffer02 : register(s1);
SamplerState sGBuffer03 : register(s2);
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
