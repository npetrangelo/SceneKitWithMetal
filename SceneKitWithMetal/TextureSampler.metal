//
//  TextureSampler.metal
//  HologramShader
//
//  Created by qe on 3/22/22.
//

#include <metal_stdlib>
using namespace metal;
#include <SceneKit/scn_metal>

struct NodeBuffer {
    float4x4 modelTransform;
    float4x4 modelViewProjectionTransform;
    float4x4 modelViewTransform;
    float4x4 normalTransform;
    float2x3 boundingBox;
};

struct VertexInput {
    float3 position [[attribute(SCNVertexSemanticPosition)]];
    float3 normal [[attribute(SCNVertexSemanticNormal)]];
    float2 uv [[attribute(SCNVertexSemanticTexcoord0)]];
};

struct VertexOut {
    float4 position [[position]];
    float3 normal;
    float2 uv;
};

vertex VertexOut textureSamplerVertex(VertexInput in [[stage_in]],
                                      constant NodeBuffer& scn_node [[buffer(1)]]) {
    VertexOut out;
    out.position = scn_node.modelViewProjectionTransform * float4(in.position, 1.0);
    out.normal = in.normal;
    out.uv = in.uv;
    return out;
}

fragment float4 textureSamplerFragment(VertexOut out [[stage_in]],
                                       texture2d<float, access::sample> customTexture [[texture(0)]]) {
//    constexpr sampler textureSampler(coord::normalized, filter::linear, address::repeat);
//    return customTexture.sample(textureSampler, out.uv);
    return float4(out.normal, 0.0);
}
