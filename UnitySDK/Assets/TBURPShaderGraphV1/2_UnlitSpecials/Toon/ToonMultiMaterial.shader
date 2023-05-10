Shader "TiltBrush/UnlitSpecials/Toon"
{
    Properties
    {
		_MainColor ("MainColor", Color) = (1.0, 1.0, 1.0, 1.0)
		[Toggle(_Inflate)] _InflateToggle ("Inflate", Float) = 0
		_OutlineMax ("Maximum Outline", Range (0,0.5)) = 0.01

		[Enum(Off,0,On,1)]	_Blend("__blend", Float) = 0.0
        _SrcBlend("__src", Float) = 1.0
        _DstBlend("__dst", Float) = 0.0
        [Enum(UnityEngine.Rendering.CompareFunction)]_ZWrite("__zw", Float) = 1.0
        [Enum(UnityEngine.Rendering.CullMode)]_Cull("__cull", Float) = 2.0
	}


	SubShader
    {
		Name "Toon"

        Tags { 
            "RenderPipeline" = "UniversalRenderPipeline"
            "IgnoreProjector"="True"
            "Queue" = "AlphaTest"
        }

		HLSLINCLUDE
		#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

		CBUFFER_START(UnityPerMaterial)
			half4 _MainColor;
			half _OutlineMax;
		CBUFFER_END

		ENDHLSL

        Pass
        {
			Name "ForwardLit"

            Tags{"LightMode" = "UniversalForward"}

			// Cull Back
            // ZWrite On
            // Blend One Zero
			Blend[_SrcBlend][_DstBlend]
            ZWrite[_ZWrite]
            Cull[_Cull]

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

			#pragma target 2.0

			#pragma shader_feature_local _Inflate

			struct Attributes
			{
				half4 positionOS	: POSITION;
				half4 color		: COLOR;
				half3 normalOS 	: NORMAL;
				half4 tangentOS    : TANGENT;
				half4 texcoord		: TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID          
			};

			struct Varyings
			{
				half4 positionCS 	: SV_POSITION;
				half4 color		: COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			Varyings vert(Attributes IN)
            {
                Varyings OUT;

				UNITY_SETUP_INSTANCE_ID(IN);
                UNITY_TRANSFER_INSTANCE_ID(IN, OUT);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);

				VertexPositionInputs vertexInput = GetVertexPositionInputs(IN.positionOS.xyz);

				#ifdef _Inflate
					VertexPositionInputs NDCInput = GetVertexPositionInputs(IN.positionOS.xyz + IN.normalOS.xyz);

					// Technically these are not yet in NDC because they haven't been divided by W, so their
					// range is currently [-W, W].
					float4 outline_NDC = NDCInput.positionCS;

					// Displacement in proper NDC coords (e.g. [-1, 1])
					float3 disp = outline_NDC.xyz / outline_NDC.w - IN.positionOS.xyz / IN.positionOS.w;

					// Magnitude is a scaling factor to shrink large outlines down to a max width, in NDC space.
					// Notice here we're only measuring 2D displacment in X and Y.
					float mag = length(disp.xy);
					mag = min(_OutlineMax, mag) / mag;

				#endif




				OUT.positionCS = vertexInput.positionCS;

				#ifdef _Inflate
					OUT.positionCS.xyz += float3(disp.xy * mag, disp.z) * IN.positionOS.w;

					// Push Z back to avoid z-fighting when scaled very small. This is not legit,
					// mathematically speaking and likely causes crazy surface derivitives.
					OUT.positionCS.z -= disp.z * IN.positionOS.w;
				#endif
				
				// color
				VertexNormalInputs normalInput = GetVertexNormalInputs(IN.normalOS, IN.tangentOS);
				OUT.color = IN.color;
				OUT.color.a = 1;
				OUT.color.rgb += normalInput.normalWS.y *.2;
				OUT.color.rgb = max(0, OUT.color.rgb);

				return OUT;
            }

			half4 frag(Varyings IN) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(IN);

				return IN.color;
			}
            ENDHLSL
        }
    }
}

