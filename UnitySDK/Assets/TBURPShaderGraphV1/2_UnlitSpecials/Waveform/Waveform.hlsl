void waveformFrag_float(float2 uv, float4 vertexColor, float4 bloomColor, out float4 color)
{
    color = float4(1, 1, 1, 1);
    float envelope = sin(uv.x * 3.14159);

    float waveform = .15 * sin( -30 * vertexColor.r * _Time.w + uv.x * 100 * vertexColor.r);
        waveform += .15 * sin( -40 * vertexColor.g * _Time.w + uv.x * 100 * vertexColor.g);
        waveform += .15 * sin( -50 * vertexColor.b * _Time.w + uv.x * 100 * vertexColor.b);

    float pinch = (1 - envelope) * 40 + 20;
    float procedural_line = saturate(1 - pinch*abs(uv.y - .5 - waveform * envelope));
    color.rgb *= envelope * procedural_line;
    color *= bloomColor;
    color = float4(color.rgb * color.a, 1);
}


void waveformFrag_half(half2 uv, half4 vertexColor, half4 bloomColor, out half4 color)
{
    color = half4(1, 1, 1, 1);
    half envelope = sin(uv.x * 3.14159);

    half waveform = .15 * sin( -30 * vertexColor.r * _Time.w + uv.x * 100 * vertexColor.r);
    waveform += .15 * sin( -40 * vertexColor.g * _Time.w + uv.x * 100 * vertexColor.g);
    waveform += .15 * sin( -50 * vertexColor.b * _Time.w + uv.x * 100 * vertexColor.b);

    half pinch = (1 - envelope) * 40 + 20;
    half procedural_line = saturate(1 - pinch*abs(uv.y - .5 - waveform * envelope));
    color.rgb *= envelope * procedural_line;
    color *= bloomColor;
    color = half4(color.rgb * color.a, 1);
}
