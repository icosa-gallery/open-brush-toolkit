float rand_1_05(in float2 uv)
{
    float2 noise = (frac(sin(dot(uv ,float2(12.9898,78.233)*2.0)) * 43758.5453));
    return abs(noise.x + noise.y) * 0.5;
}

void streamersUVS_float(float2 uv0, float4 vertexColor, out float2 uvs)
{
    // Create parametric flowing UV's
    uvs = uv0;
    float row_id = floor(uvs.y * 5);
    float row_rand = rand_1_05(row_id.xx);
    uvs.x += row_rand * 200;

    float2 sins = sin(uvs.x * float2(10,23) + _Time.z * float2(5,3));
    uvs.y = 5 * uvs.y + dot(float2(.05, -.05), sins);

    // Scrolling UVs
    uvs.x *= .5 + row_rand * .3;
    uvs.x -= _Time.y * (1 + fmod(row_id * 1.61803398875, 1) - 0.5);
}
