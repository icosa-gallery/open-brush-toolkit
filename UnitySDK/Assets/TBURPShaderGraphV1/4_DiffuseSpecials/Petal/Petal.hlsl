void petalFrag_float(float2 uv, float4 vertexColor, float vface, out float4 finalColor, out float fAO)
{
    float4 darker_color = vertexColor * 0.6;
    finalColor = lerp(vertexColor, darker_color, 1 - uv.x);
    fAO = vface == -1 ? .5 * uv.x : 1;
}

void petalFrag_half(half2 uv, half4 vertexColor, half vface, out half4 finalColor, out half fAO)
{
    half4 darker_color = vertexColor * 0.6;
    finalColor = lerp(vertexColor, darker_color, 1 - uv.x);
    fAO = vface == -1 ? .5 * uv.x : 1;
}

