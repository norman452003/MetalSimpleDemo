//
//  KSRender.m
//  MetalDemo
//
//  Created by gx on 2022/4/10.
//

#import "KSRender.h"
#import "MetalType.h"

@interface KSRender ()
{
    vector_float2 _viewportSize;
}
@property (nonatomic,strong) id<MTLDevice> device;

@property (nonatomic,strong) id<MTLCommandQueue> commandQueue;

@property (nonatomic,strong) id<MTLRenderPipelineState> renderPipelineState;

@end

@implementation KSRender

- (instancetype)initWithMTKView:(MTKView *)view {
    if (self = [super init]) {
        self.device = view.device;
        
        id<MTLLibrary> mtlLibrary = [self.device newDefaultLibrary];
        id<MTLFunction> vertexFunction = [mtlLibrary newFunctionWithName:@"vertexShader"];
        id<MTLFunction> fragmentFunction = [mtlLibrary newFunctionWithName:@"fragmentShader"];
        
        MTLRenderPipelineDescriptor *renderPipelineDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
        renderPipelineDescriptor.vertexFunction = vertexFunction;
        renderPipelineDescriptor.fragmentFunction = fragmentFunction;
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = view.colorPixelFormat;
        
        self.renderPipelineState = [self.device newRenderPipelineStateWithDescriptor:renderPipelineDescriptor error:NULL];
        
        
        self.commandQueue = [self.device newCommandQueue];
        
        
    }
    return self;
}

- (void)drawInMTKView:(MTKView *)view {
    static const KSVertex vertexs[] = {
        {{250,-250},{1,0,0,1}},
        {{-250,-250},{0,1,0,1}},
        {{-250,250},{0,0,1,1}},
        
        {{-250,250},{0,0,1,1}},
        {{250,250},{0,1,0,1}},
        {{250,-250},{1,0,0,1}},
    };
    
    id<MTLCommandBuffer> buffer = [self.commandQueue commandBuffer];
    buffer.label = @"command buffer 1";
    
    id<MTLRenderCommandEncoder> commandEncoder = [buffer renderCommandEncoderWithDescriptor:view.currentRenderPassDescriptor];
    
    [commandEncoder setVertexBytes:vertexs length:sizeof(vertexs) atIndex:KSVertexInputPosition];
    
    [commandEncoder setVertexBytes:&_viewportSize length:sizeof(_viewportSize) atIndex:KSVertexInputIndexViewportSize];
    [commandEncoder setRenderPipelineState:self.renderPipelineState];
    
    [commandEncoder drawPrimitives:MTLPrimitiveTypeTriangle vertexStart:0 vertexCount:6];
    
    [commandEncoder endEncoding];
    
    [buffer presentDrawable:view.currentDrawable];
    [buffer commit];
    
}

- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
    _viewportSize.x = size.width;
    _viewportSize.y = size.height;
}

- (MTLClearColor)randomColor {
    return MTLClearColorMake(((double)arc4random() / UINT32_MAX), ((double)arc4random() / UINT32_MAX), ((double)arc4random() / UINT32_MAX), 1);
}

@end
