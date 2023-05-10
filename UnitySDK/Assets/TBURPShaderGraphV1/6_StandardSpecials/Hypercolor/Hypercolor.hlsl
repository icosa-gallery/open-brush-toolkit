void hypercolorAnim_float(float4 albedo, float2 uv, out float4 color)
{
    color = albedo;
    float scroll = _Time.z;

    color.rgb =  float3(1,0,0) * (sin(color.r * 2 + scroll*0.5 - uv.x) + 1) * 2;
    color.rgb += float3(0,1,0) * (sin(color.r * 3.3 + scroll*1 - uv.x) + 1) * 2;
    color.rgb += float3(0,0,1) * (sin(color.r * 4.66 + scroll*0.25 - uv.x) + 1) * 2;
}

void hypercolorAnim_half(half4 albedo, half2 uv, out half4 color)
{
    color = half4(0, 0, 0, 1);
    half scroll = _Time.z;

    albedo.rgb =  half3(1,0,0) * (sin(albedo.r * 2 + scroll*0.5 - uv.x) + 1) * 2;
    albedo.rgb += half3(0,1,0) * (sin(albedo.r * 3.3 + scroll*1 - uv.x) + 1) * 2;
    albedo.rgb += half3(0,0,1) * (sin(albedo.r * 4.66 + scroll*0.25 - uv.x) + 1) * 2;
}
