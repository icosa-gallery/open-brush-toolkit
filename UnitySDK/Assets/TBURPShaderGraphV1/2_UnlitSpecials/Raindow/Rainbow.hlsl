void rainbowFrag_float(float2 uv0, float4 vertexColor, float emissionGain, out float3 color)
{
    color = float3(0, 0, 0);

    vertexColor.a = 1;

    // Create parametric UV's
    float2 uvs = saturate(uv0);
    float row_id = floor(uvs.y * 5);
    uvs.y *= 5;

    // Create parametric colors
    float4 tex = float4(0,0,0,1);
    float4 row_y = fmod(uvs.y,1);

    row_id = ceil(fmod(row_id + _Time.z,5)) - 1;

    tex.rgb = row_id == 0 ? float3(1,0,0) : tex.rgb;
    tex.rgb = row_id == 1 ? float3(.7,.3,0) : tex.rgb;
    tex.rgb = row_id == 2 ? float3(0,1,.0) : tex.rgb;
    tex.rgb = row_id == 3 ? float3(0,.2,1) : tex.rgb;
    tex.rgb = row_id == 4 ? float3(.4,0,1.2) : tex.rgb;

    // Make rainbow lines pulse
    tex.rgb *= pow( (sin(row_id * 1 + _Time.z)   + 1)/2,5);

    // Make rainbow lines thin
    tex.rgb *= saturate(pow(row_y * (1 - row_y) * 5, 50));

    tex *= vertexColor * exp(emissionGain * 3.0f);

    color = tex.rgb * tex.a;
}

void rainbowFrag_half(half2 uv0, half4 vertexColor, half emissionGain, out half3 color)
{
    color = half3(0, 0, 0);

    vertexColor.a = 1;

    // Create parametric UV's
    half2 uvs = saturate(uv0);
    half row_id = floor(uvs.y * 5);
    uvs.y *= 5;

    // Create parametric colors
    half4 tex = half4(0,0,0,1);
    half row_y = fmod(uvs.y,1);

    row_id = ceil(fmod(row_id + _Time.z,5)) - 1;

    tex.rgb = row_id == 0 ? half3(1,0,0) : tex.rgb;
    tex.rgb = row_id == 1 ? half3(.7,.3,0) : tex.rgb;
    tex.rgb = row_id == 2 ? half3(0,1,.0) : tex.rgb;
    tex.rgb = row_id == 3 ? half3(0,.2,1) : tex.rgb;
    tex.rgb = row_id == 4 ? half3(.4,0,1.2) : tex.rgb;

    // Make rainbow lines pulse
    tex.rgb *= pow( (sin(row_id * 1 + _Time.z)   + 1)/2,5);

    // Make rainbow lines thin
    tex.rgb *= saturate(pow(row_y * (1 - row_y) * 5, 50));

    tex *= vertexColor * exp(emissionGain * 3.0f);

    color = tex.rgb * tex.a;
}
