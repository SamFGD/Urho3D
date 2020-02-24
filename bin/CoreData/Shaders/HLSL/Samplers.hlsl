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
sampler2D sTex2d01 : register(s0);
sampler3D sTex3d01 : register(s0);
samplerCUBE sCube01 : register(s0);
sampler2D sGBuffer01 : register(s0);
sampler2D sTex2d02 : register(s1);
sampler3D sTex3d02 : register(s1);
samplerCUBE sCube02 : register(s1);
sampler2D sGBuffer02 : register(s1);
sampler2D sTex2d03 : register(s2);
sampler3D sTex3d03 : register(s2);
samplerCUBE sCube03 : register(s2);
sampler2D sGBuffer03 : register(s2);
sampler2D sTex2d04 : register(s3);
sampler3D sTex3d04 : register(s3);
samplerCUBE sCube04 : register(s3);
sampler2D sTex2d05 : register(s4);
sampler3D sTex3d05 : register(s4);
samplerCUBE sCube05 : register(s4);
sampler2D sTex2d06 : register(s5);
sampler3D sTex3d06 : register(s5);
samplerCUBE sCube06 : register(s5);
sampler2D sTex2d07 : register(s6);
sampler3D sTex3d07 : register(s6);
samplerCUBE sCube07 : register(s6);
sampler2D sTex2d08 : register(s7);
sampler3D sTex3d08 : register(s7);
samplerCUBE sCube08 : register(s7);
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

Texture2D tTex2d01 : register(t0);
Texture3D tTex3d01 : register(t0);
TextureCube tCube01 : register(t0);
Texture2D tGbuffer01 : register(t0);
Texture2D tTex2d02 : register(t1);
Texture3D tTex3d02 : register(t1);
TextureCube tCube02 : register(t1);
Texture2D tGbuffer02 : register(t1);
Texture2D tTex2d03 : register(t2);
Texture3D tTex3d03 : register(t2);
TextureCube tCube03 : register(t2);
Texture2D tGbuffer03 : register(t2);
Texture2D tTex2d04 : register(t3);
Texture3D tTex3d04 : register(t3);
TextureCube tCube04 : register(t3);
Texture2D tTex2d05 : register(t4);
Texture3D tTex3d05 : register(t4);
TextureCube tCube05 : register(t4);
Texture2D tTex2d06 : register(t5);
Texture3D tTex3d06 : register(t5);
TextureCube tCube06 : register(t5);
Texture2D tTex2d07 : register(t6);
Texture3D tTex3d07 : register(t6);
TextureCube tCube07 : register(t6);
Texture2D tTex2d08 : register(t7);
Texture3D tTex3d08 : register(t7);
TextureCube tCube08 : register(t7);
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

SamplerState sTex2d01 : register(s0);
SamplerState sTex3d01 : register(s0);
SamplerState sCube01 : register(s0);
SamplerState sGbuffer01 : register(s0);
SamplerState sTex2d02 : register(s1);
SamplerState sTex3d02 : register(s1);
SamplerState sCube02 : register(s1);
SamplerState sGBuffer02 : register(s1);
SamplerState sTex2d03 : register(s2);
SamplerState sTex3d03 : register(s2);
SamplerState sCube03 : register(s2);
SamplerState sGBuffer03 : register(s2);
SamplerState sTex2d04 : register(s3);
SamplerState sTex3d04 : register(s3);
SamplerState sCube04 : register(s3);
SamplerState sTex2d05 : register(s4);
SamplerState sTex3d05 : register(s4);
SamplerState sCube05 : register(s4);
SamplerState sTex2d06 : register(s5);
SamplerState sTex3d06 : register(s5);
SamplerState sCube06 : register(s5);
SamplerState sTex2d07 : register(s6);
SamplerState sTex3d07 : register(s6);
SamplerState sCube07 : register(s6);
SamplerState sTex2d08 : register(s7);
SamplerState sTex3d08 : register(s7);
SamplerState sCube08 : register(s7);
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
