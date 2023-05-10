void findScrollUV_float(float2 uv0, out float2 scrollUV, out float2 scrollUV2, out float2 scrollUV3 )
{
    float time = _Time.y * - 1;

    scrollUV = uv0;
    scrollUV2 = uv0;
    scrollUV3 = uv0;

    scrollUV.y += time; // a little twisting motion
    scrollUV.x += time;
    scrollUV2.x += time * 1.5;
    scrollUV3.x += time * 0.5;
}


void cometFrag_float(float r, float g, float b, float2 uv0, out float out_uv)
{
    out_uv = 0;

    // Combine all channels
    float gradient_lookup_value = (r + g + b) / 3.0;
    gradient_lookup_value *= (1 - uv0.x); // rescales the lookup value from start to finish
    gradient_lookup_value = (pow(gradient_lookup_value, 2) + 0.125) * 3;

    float falloff = max((0.2 - uv0.x) * 5, 0);

    out_uv = saturate(gradient_lookup_value + falloff);
}

void findScrollUV_half(half2 uv0, out half2 scrollUV, out half2 scrollUV2, out half2 scrollUV3 )
{
    half time = _Time.y * - 1;

    scrollUV = uv0;
    scrollUV2 = uv0;
    scrollUV3 = uv0;

    scrollUV.y += time; // a little twisting motion
    scrollUV.x += time;
    scrollUV2.x += time * 1.5;
    scrollUV3.x += time * 0.5;
}


void cometFrag_half(half r, half g, half b, half2 uv0, out half out_uv)
{
    out_uv = 0;

    // Combine all channels
    half gradient_lookup_value = (r + g + b) / 3.0;
    gradient_lookup_value *= (1 - uv0.x); // rescales the lookup value from start to finish
    gradient_lookup_value = (pow(gradient_lookup_value, 2) + 0.125) * 3;

    half falloff = max((0.2 - uv0.x) * 5, 0);

    out_uv = saturate(gradient_lookup_value + falloff);
}
