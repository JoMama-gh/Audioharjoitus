Shader "Polytope Studio/ PT_Medieval Modular NPC Shader PBR (URP)"
{
    Properties
    {
		[HDR]_SKINCOLOR("SKIN COLOR", Color) = (2.02193,1.0081,0.6199315,0)
		_SKINSMOOTHNESS("SKIN SMOOTHNESS", Range( 0 , 1)) = 0.3
		[HDR]_EYESCOLOR("EYES COLOR", Color) = (0.0734529,0.1320755,0.05046281,1)
		_EYESSMOOTHNESS("EYES SMOOTHNESS", Range( 0 , 1)) = 0.7
		[HDR]_HAIRCOLOR("HAIR COLOR", Color) = (1,0,0,0)
		_HAIRSMOOTHNESS("HAIR SMOOTHNESS", Range( 0 , 1)) = 0.1
		[HDR]_SCLERACOLOR("SCLERA COLOR", Color) = (0.9056604,0.8159487,0.8159487,0)
		_SCLERASMOOTHNESS("SCLERA SMOOTHNESS", Range( 0 , 1)) = 0.5
		[HDR]_LIPSCOLOR("LIPS COLOR", Color) = (0.8301887,0.3185886,0.2780349,0)
		_LIPSSMOOTHNESS("LIPS SMOOTHNESS", Range( 0 , 1)) = 0.4
		[HDR]_OTHERCOLOR("OTHER COLOR", Color) = (0.5188679,0.4637216,0.3206212,0)
		_OTHERSMOOTHNESS("OTHER SMOOTHNESS", Range( 0 , 1)) = 0.3
		[HDR]_METAL1COLOR("METAL 1 COLOR", Color) = (0.8792791,0.9922886,1.007606,0)
		_METAL1METALLIC("METAL 1 METALLIC", Range( 0 , 1)) = 0.65
		_METAL1SMOOTHNESS("METAL 1 SMOOTHNESS", Range( 0 , 1)) = 0.7
		[HDR]_METAL2COLOR("METAL 2 COLOR", Color) = (0.4674706,0.4677705,0.5188679,0)
		_METAL2METALLIC("METAL 2 METALLIC", Range( 0 , 1)) = 0.65
		_METAL2SMOOTHNESS("METAL 2 SMOOTHNESS", Range( 0 , 1)) = 0.7
		[HDR]_METAL3COLOR("METAL 3 COLOR", Color) = (0.4383232,0.4383232,0.4716981,0)
		_METAL3METALLIC("METAL 3 METALLIC", Range( 0 , 1)) = 0.65
		_METAL3SMOOTHNESS("METAL 3 SMOOTHNESS", Range( 0 , 1)) = 0.7
		[HDR]_METAL4COLOR("METAL 4 COLOR", Color) = (0.4383232,0.4383232,0.4716981,0)
		_METAL4METALLIC("METAL 4 METALLIC", Range( 0 , 1)) = 0.65
		_METAL4SMOOTHNESS("METAL 4 SMOOTHNESS", Range( 0 , 1)) = 0.7
		[HDR]_LEATHER1COLOR("LEATHER 1 COLOR", Color) = (0.4811321,0.2041155,0.08851016,1)
		_LEATHER1SMOOTHNESS("LEATHER 1 SMOOTHNESS", Range( 0 , 1)) = 0.3
		[HDR]_LEATHER2COLOR("LEATHER 2 COLOR", Color) = (0.4245283,0.190437,0.09011215,1)
		_LEATHER2SMOOTHNESS("LEATHER 2 SMOOTHNESS", Range( 0 , 1)) = 0.3
		[HDR]_LEATHER3COLOR("LEATHER 3 COLOR", Color) = (0.1698113,0.04637412,0.02963688,1)
		_LEATHER3SMOOTHNESS("LEATHER 3 SMOOTHNESS", Range( 0 , 1)) = 0.3
		[HDR]_LEATHER4COLOR("LEATHER 4 COLOR", Color) = (0.1698113,0.04637412,0.02963688,1)
		_LEATHER4SMOOTHNESS("LEATHER 4 SMOOTHNESS", Range( 0 , 1)) = 0.3
		[HDR]_CLOTH1COLOR("CLOTH 1 COLOR", Color) = (0,0.1792453,0.05062231,0)
		[HDR]_CLOTH2COLOR("CLOTH 2 COLOR", Color) = (1,0,0,0)
		[HDR]_CLOTH3COLOR("CLOTH 3 COLOR", Color) = (0.3962264,0.3391397,0.2710039,0)
		[HDR]_CLOTH4COLOR("CLOTH 4 COLOR", Color) = (0.2011392,0.3773585,0.3739074,0)
		[HDR]_FEATHERS1COLOR("FEATHERS 1 COLOR", Color) = (0.7735849,0.492613,0.492613,0)
		[HDR]_FEATHERS2COLOR("FEATHERS 2 COLOR", Color) = (0.6792453,0,0,0)
		_OCCLUSION("OCCLUSION", Range( 0 , 1)) = 0.5
		[Toggle]_MetalicOn("Metalic On", Float) = 1
		[Toggle]_SmoothnessOn("Smoothness On", Float) = 1
		[HideInInspector]_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HideInInspector]_TextureSample2("Texture Sample 2", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
    }

    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
        Cull Back

        Pass
        {
            Name "ForwardLit"
            Tags { "LightMode"="UniversalForward" }

            HLSLPROGRAM
            #pragma target 3.5
            #pragma vertex Vert
            #pragma fragment Frag
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _SHADOWS_SOFT
            #pragma multi_compile_fog
            #pragma multi_compile_instancing

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            TEXTURE2D(_TextureSample2); SAMPLER(sampler_TextureSample2);
            TEXTURE2D(_TextureSample0); SAMPLER(sampler_TextureSample0);
            CBUFFER_START(UnityPerMaterial)
                float4 _TextureSample2_ST;
                float4 _TextureSample0_ST;
                float4 _FEATHERS2COLOR, _FEATHERS1COLOR;
                float4 _CLOTH4COLOR, _CLOTH3COLOR, _CLOTH2COLOR, _CLOTH1COLOR;
                float4 _LEATHER4COLOR, _LEATHER3COLOR, _LEATHER2COLOR, _LEATHER1COLOR;
                float4 _METAL4COLOR, _METAL3COLOR, _METAL2COLOR, _METAL1COLOR;
                float4 _OTHERCOLOR, _LIPSCOLOR, _SCLERACOLOR, _EYESCOLOR, _HAIRCOLOR, _SKINCOLOR;
                float _MetalicOn, _METAL4METALLIC, _METAL3METALLIC, _METAL2METALLIC, _METAL1METALLIC;
                float _SmoothnessOn;
                float _LEATHER4SMOOTHNESS, _LEATHER3SMOOTHNESS, _LEATHER2SMOOTHNESS, _LEATHER1SMOOTHNESS;
                float _METAL4SMOOTHNESS, _METAL3SMOOTHNESS, _METAL2SMOOTHNESS, _METAL1SMOOTHNESS;
                float _OTHERSMOOTHNESS, _LIPSSMOOTHNESS, _SCLERASMOOTHNESS, _EYESSMOOTHNESS;
                float _HAIRSMOOTHNESS, _SKINSMOOTHNESS, _OCCLUSION;
            CBUFFER_END

            struct Attributes
            {
                float4 positionOS : POSITION;
                float3 normalOS : NORMAL;
                float2 uv : TEXCOORD0;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 positionWS : TEXCOORD1;
                half3 normalWS : TEXCOORD2;
                float4 shadowCoord : TEXCOORD3;
                half fogFactor : TEXCOORD4;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                UNITY_VERTEX_OUTPUT_STEREO
            };

            Varyings Vert(Attributes v)
            {
                Varyings o = (Varyings)0;
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_TRANSFER_INSTANCE_ID(v, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
                VertexPositionInputs pos = GetVertexPositionInputs(v.positionOS.xyz);
                VertexNormalInputs nrm = GetVertexNormalInputs(v.normalOS);
                o.positionCS = pos.positionCS;
                o.positionWS = pos.positionWS;
                o.normalWS = nrm.normalWS;
                o.uv = v.uv;
                o.shadowCoord = GetShadowCoord(pos);
                o.fogFactor = ComputeFogFactor(pos.positionCS.z);
                return o;
            }

            struct SurfaceOutputStandard
            {
                float3 Albedo;
                float Metallic;
                float Smoothness;
                float Occlusion;
                float Alpha;
            };

            struct Input { float2 uv_texcoord; };

            void surf(Input i, inout SurfaceOutputStandard o)
            {
			float2 uv_TextureSample2 = i.uv_texcoord * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
			float4 tex2DNode199 = SAMPLE_TEXTURE2D(_TextureSample2, sampler_TextureSample2, uv_TextureSample2);
			float4 color638 = IsGammaSpace() ? float4(0.4980392,1,1,1) : float4(0.2122307,1,1,1);
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode617 = SAMPLE_TEXTURE2D(_TextureSample0, sampler_TextureSample0, uv_TextureSample0);
			float4 lerpResult189 = lerp( float4( 0,0,0,0 ) , ( tex2DNode199 * _FEATHERS2COLOR ) , saturate( ( 1.0 - ( ( distance( color638.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
			float4 color637 = IsGammaSpace() ? float4(0.4980392,1,0.4980392,1) : float4(0.2122307,1,0.2122307,1);
			float4 lerpResult184 = lerp( lerpResult189 , ( tex2DNode199 * _FEATHERS1COLOR ) , saturate( ( 1.0 - ( ( distance( color637.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
			float4 color636 = IsGammaSpace() ? float4(0,0,1,1) : float4(0,0,1,1);
			float4 lerpResult598 = lerp( lerpResult184 , ( tex2DNode199 * _CLOTH4COLOR ) , saturate( ( 1.0 - ( ( distance( color636.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
			float4 color635 = IsGammaSpace() ? float4(0,1,1,1) : float4(0,1,1,1);
			float4 lerpResult171 = lerp( lerpResult598 , ( tex2DNode199 * _CLOTH3COLOR ) , saturate( ( 1.0 - ( ( distance( color635.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
			float4 color634 = IsGammaSpace() ? float4(0,1,0,1) : float4(0,1,0,1);
			float4 lerpResult178 = lerp( lerpResult171 , ( tex2DNode199 * _CLOTH2COLOR ) , saturate( ( 1.0 - ( ( distance( color634.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
			float4 color633 = IsGammaSpace() ? float4(0,0.4980392,0,1) : float4(0,0.2122307,0,1);
			float4 lerpResult173 = lerp( lerpResult178 , ( tex2DNode199 * _CLOTH1COLOR ) , saturate( ( 1.0 - ( ( distance( color633.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) ));
			float4 color632 = IsGammaSpace() ? float4(1,0.4980392,0.4980392,1) : float4(1,0.2122307,0.2122307,1);
			float temp_output_599_0 = saturate( ( 1.0 - ( ( distance( color632.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult602 = lerp( lerpResult173 , ( tex2DNode199 * _LEATHER4COLOR ) , temp_output_599_0);
			float4 color631 = IsGammaSpace() ? float4(1,1,0.4980392,1) : float4(1,1,0.2122307,1);
			float temp_output_165_0 = saturate( ( 1.0 - ( ( distance( color631.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult160 = lerp( lerpResult602 , ( tex2DNode199 * _LEATHER3COLOR ) , temp_output_165_0);
			float4 color630 = IsGammaSpace() ? float4(1,0,1,1) : float4(1,0,1,1);
			float temp_output_158_0 = saturate( ( 1.0 - ( ( distance( color630.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult167 = lerp( lerpResult160 , ( tex2DNode199 * _LEATHER2COLOR ) , temp_output_158_0);
			float4 color629 = IsGammaSpace() ? float4(1,0.4980392,1,1) : float4(1,0.2122307,1,1);
			float temp_output_157_0 = saturate( ( 1.0 - ( ( distance( color629.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult162 = lerp( lerpResult167 , ( tex2DNode199 * _LEATHER1COLOR ) , temp_output_157_0);
			float4 color628 = IsGammaSpace() ? float4(0.4980392,0.4980392,1,1) : float4(0.2122307,0.2122307,1,1);
			float temp_output_603_0 = saturate( ( 1.0 - ( ( distance( color628.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult606 = lerp( lerpResult162 , ( tex2DNode199 * _METAL4COLOR ) , temp_output_603_0);
			float4 color627 = IsGammaSpace() ? float4(0,0.4980392,0.4980392,1) : float4(0,0.2122307,0.2122307,1);
			float temp_output_117_0 = saturate( ( 1.0 - ( ( distance( color627.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult118 = lerp( lerpResult606 , ( tex2DNode199 * _METAL3COLOR ) , temp_output_117_0);
			float4 color625 = IsGammaSpace() ? float4(0,0,0.4980392,1) : float4(0,0,0.2122307,1);
			float temp_output_127_0 = saturate( ( 1.0 - ( ( distance( color625.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult128 = lerp( lerpResult118 , ( tex2DNode199 * _METAL2COLOR ) , temp_output_127_0);
			float4 color624 = IsGammaSpace() ? float4(0.4980392,0,0.4980392,1) : float4(0.2122307,0,0.2122307,1);
			float temp_output_123_0 = saturate( ( 1.0 - ( ( distance( color624.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult122 = lerp( lerpResult128 , ( tex2DNode199 * _METAL1COLOR ) , temp_output_123_0);
			float4 color623 = IsGammaSpace() ? float4(1,1,0,1) : float4(1,1,0,1);
			float temp_output_145_0 = saturate( ( 1.0 - ( ( distance( color623.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult148 = lerp( lerpResult122 , ( tex2DNode199 * _OTHERCOLOR ) , temp_output_145_0);
			float4 color622 = IsGammaSpace() ? float4(0.4980392,0.4980392,0,1) : float4(0.2122307,0.2122307,0,1);
			float temp_output_149_0 = saturate( ( 1.0 - ( ( distance( color622.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult151 = lerp( lerpResult148 , ( tex2DNode199 * _LIPSCOLOR ) , temp_output_149_0);
			float4 color621 = IsGammaSpace() ? float4(0.4980392,0.4980392,0.4980392,1) : float4(0.2122307,0.2122307,0.2122307,1);
			float temp_output_150_0 = saturate( ( 1.0 - ( ( distance( color621.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult153 = lerp( lerpResult151 , ( tex2DNode199 * _SCLERACOLOR ) , temp_output_150_0);
			float4 color618 = IsGammaSpace() ? float4(1,0,0,1) : float4(1,0,0,1);
			float temp_output_71_0 = saturate( ( 1.0 - ( ( distance( color618.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult73 = lerp( lerpResult153 , ( tex2DNode199 * _EYESCOLOR ) , temp_output_71_0);
			float4 color619 = IsGammaSpace() ? float4(1,0.4980392,0,1) : float4(1,0.2122307,0,1);
			float temp_output_67_0 = saturate( ( 1.0 - ( ( distance( color619.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult69 = lerp( lerpResult73 , ( tex2DNode199 * _HAIRCOLOR ) , temp_output_67_0);
			float4 color620 = IsGammaSpace() ? float4(0.4980392,0,0,1) : float4(0.2122307,0,0,1);
			float temp_output_63_0 = saturate( ( 1.0 - ( ( distance( color620.rgb , tex2DNode617.rgb ) - 0.1 ) / max( 0.0 , 1E-05 ) ) ) );
			float4 lerpResult62 = lerp( lerpResult69 , ( tex2DNode199 * _SKINCOLOR ) , temp_output_63_0);
			o.Albedo = lerpResult62.rgb;
			float lerpResult610 = lerp( 0.0 , _METAL4METALLIC , temp_output_603_0);
			float lerpResult315 = lerp( lerpResult610 , _METAL3METALLIC , temp_output_117_0);
			float lerpResult319 = lerp( lerpResult315 , _METAL2METALLIC , temp_output_127_0);
			float lerpResult316 = lerp( lerpResult319 , _METAL1METALLIC , temp_output_123_0);
			o.Metallic = (( _MetalicOn )?( lerpResult316 ):( 0.0 ));
			float lerpResult612 = lerp( 0.0 , _LEATHER4SMOOTHNESS , temp_output_599_0);
			float lerpResult336 = lerp( lerpResult612 , _LEATHER3SMOOTHNESS , temp_output_165_0);
			float lerpResult332 = lerp( lerpResult336 , _LEATHER2SMOOTHNESS , temp_output_158_0);
			float lerpResult334 = lerp( lerpResult332 , _LEATHER1SMOOTHNESS , temp_output_157_0);
			float lerpResult608 = lerp( lerpResult334 , _METAL4SMOOTHNESS , temp_output_603_0);
			float lerpResult327 = lerp( lerpResult608 , _METAL3SMOOTHNESS , temp_output_117_0);
			float lerpResult331 = lerp( lerpResult327 , _METAL2SMOOTHNESS , temp_output_127_0);
			float lerpResult328 = lerp( lerpResult331 , _METAL1SMOOTHNESS , temp_output_123_0);
			float lerpResult321 = lerp( lerpResult328 , _OTHERSMOOTHNESS , temp_output_145_0);
			float lerpResult325 = lerp( lerpResult321 , _LIPSSMOOTHNESS , temp_output_149_0);
			float lerpResult322 = lerp( lerpResult325 , _SCLERASMOOTHNESS , temp_output_150_0);
			float lerpResult306 = lerp( lerpResult322 , _EYESSMOOTHNESS , temp_output_71_0);
			float lerpResult304 = lerp( lerpResult306 , _HAIRSMOOTHNESS , temp_output_67_0);
			float lerpResult302 = lerp( lerpResult304 , _SKINSMOOTHNESS , temp_output_63_0);
			o.Smoothness = (( _SmoothnessOn )?( lerpResult302 ):( 0.0 ));
			o.Occlusion = (1.0 + (_OCCLUSION - 0.0) * (0.5 - 1.0) / (1.0 - 0.0));
			o.Alpha = 1;
            }

            half4 Frag(Varyings i) : SV_Target
            {
                UNITY_SETUP_INSTANCE_ID(i);
                UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);

                Input input;
                input.uv_texcoord = i.uv;

                SurfaceOutputStandard s = (SurfaceOutputStandard)0;
                surf(input, s);

                SurfaceData surfaceData = (SurfaceData)0;
                surfaceData.albedo = s.Albedo;
                surfaceData.metallic = s.Metallic;
                surfaceData.specular = 0;
                surfaceData.smoothness = s.Smoothness;
                surfaceData.normalTS = half3(0, 0, 1);
                surfaceData.occlusion = s.Occlusion;
                surfaceData.emission = 0;
                surfaceData.alpha = s.Alpha;
                surfaceData.clearCoatMask = 0;
                surfaceData.clearCoatSmoothness = 0;

                InputData inputData = (InputData)0;
                inputData.positionWS = i.positionWS;
                inputData.normalWS = NormalizeNormalPerPixel(i.normalWS);
                inputData.viewDirectionWS = GetWorldSpaceNormalizeViewDir(i.positionWS);
                inputData.shadowCoord = i.shadowCoord;
                inputData.fogCoord = i.fogFactor;
                inputData.vertexLighting = VertexLighting(i.positionWS, inputData.normalWS);
                inputData.bakedGI = SampleSH(inputData.normalWS);
                inputData.normalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(i.positionCS);
                inputData.shadowMask = half4(1, 1, 1, 1);

                half4 color = UniversalFragmentPBR(inputData, surfaceData);
                color.rgb = MixFog(color.rgb, i.fogFactor);
                return color;
            }
            ENDHLSL
        }

        UsePass "Universal Render Pipeline/Lit/ShadowCaster"
        UsePass "Universal Render Pipeline/Lit/DepthOnly"
    }
    FallBack "Hidden/Universal Render Pipeline/FallbackError"
}
