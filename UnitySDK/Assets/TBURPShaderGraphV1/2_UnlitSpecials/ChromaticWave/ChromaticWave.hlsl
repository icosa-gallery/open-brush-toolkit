void chromaticWaveFrag_float(float2 uv, float4 vertexColor, float4 bloomColor, out float4 color, out float alpha)
{
    alpha = 0;
    color = float4(0, 0, 0, 1);

    float envelope = sin(uv.x * 3.14159);
    uv.y += uv.x * 3;

    float waveform_r = .15 * sin( -20 * vertexColor.r * _Time.w + uv.x * 100 * vertexColor.r);
    float waveform_g = .15 * sin( -30 * vertexColor.g * _Time.w + uv.x * 100 * vertexColor.g);
    float waveform_b = .15 * sin( -40 * vertexColor.b * _Time.w + uv.x * 100 * vertexColor.b);

    uv.y = fmod(uv.y + uv.x, 1);
    float procedural_line_r = saturate(1 - 40*abs(uv.y - .5 + waveform_r));
    float procedural_line_g = saturate(1 - 40*abs(uv.y - .5 + waveform_g));
    float procedural_line_b = saturate(1 - 40*abs(uv.y - .5 + waveform_b));

    color = procedural_line_r * float4(1,0,0,0) + 
            procedural_line_g * float4(0,1,0,0) + 
            procedural_line_b * float4(0,0,1,0);

    color.w = 1;
    color *= bloomColor;
    alpha = color.a;
}

void chromaticWaveFrag_half(half2 uv, half4 vertexColor, half4 bloomColor, out half4 color, out half alpha)
{
    alpha = 0;
    color = half4(0, 0, 0, 1);

    half envelope = sin(uv.x * 3.14159);
    uv.y += uv.x * 3;

    half waveform_r = .15 * sin( -20 * vertexColor.r * _Time.w + uv.x * 100 * vertexColor.r);
    half waveform_g = .15 * sin( -30 * vertexColor.g * _Time.w + uv.x * 100 * vertexColor.g);
    half waveform_b = .15 * sin( -40 * vertexColor.b * _Time.w + uv.x * 100 * vertexColor.b);

    uv.y = fmod(uv.y + uv.x, 1);
    half procedural_line_r = saturate(1 - 40*abs(uv.y - .5 + waveform_r));
    half procedural_line_g = saturate(1 - 40*abs(uv.y - .5 + waveform_g));
    half procedural_line_b = saturate(1 - 40*abs(uv.y - .5 + waveform_b));

    color = procedural_line_r * half4(1,0,0,0) + 
            procedural_line_g * half4(0,1,0,0) + 
            procedural_line_b * half4(0,0,1,0);

    color.w = 1;
    color *= bloomColor;
    alpha = color.a;
}