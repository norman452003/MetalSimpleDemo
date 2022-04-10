//
//  MetalType.h
//  MetalDemo
//
//  Created by gx on 2022/4/10.
//

#ifndef MetalType_h
#define MetalType_h

typedef struct KSVertex{
    vector_float2 position;
    vector_float4 color;
} KSVertex;

typedef enum {
    KSVertexInputPosition = 0,
    KSVertexInputIndexViewportSize = 1,
} KSVertexInputIndex;

#endif /* MetalType_h */
