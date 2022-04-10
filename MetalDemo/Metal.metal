//
//  Metal.metal
//  MetalDemo
//
//  Created by gx on 2022/4/10.
//

#include <metal_stdlib>
#include "MetalType.h"
using namespace metal;

typedef struct VertexReturnObj {
    float4 outPosition [[position]];
    float4 color;
} VertexReturnObj;

vertex VertexReturnObj vertexShader(uint vertexId [[vertex_id]],constant KSVertex *vertexs [[buffer(KSVertexInputPosition)]],constant vector_float2 *viewportSizePointer[[buffer(KSVertexInputIndexViewportSize)]]) {
    VertexReturnObj out = VertexReturnObj();
    KSVertex vertexStruct = vertexs[vertexId];
    out.color = vertexStruct.color;
    
    out.outPosition = {0.0,0.0,0.0,1.0};
    
    float2 viewportSize = vector_float2(*viewportSizePointer);
    float2 pixSpace = vertexStruct.position.xy;
    out.outPosition.xy = pixSpace / (viewportSize/2);
    
    return out;
    
}

fragment float4 fragmentShader(VertexReturnObj in[[stage_in]]) {
    return in.color;
}
