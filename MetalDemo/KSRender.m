//
//  KSRender.m
//  MetalDemo
//
//  Created by gx on 2022/4/10.
//

#import "KSRender.h"

@interface KSRender ()

@property (nonatomic,strong) id<MTLDevice> device;

@property (nonatomic,strong) id<MTLCommandQueue> commandQueue;
@end

@implementation KSRender

- (instancetype)initWithMTKView:(MTKView *)view {
    if (self = [super init]) {
        self.device = view.device;
        
        self.commandQueue = [self.device newCommandQueue];
    }
    return self;
}

- (void)drawInMTKView:(MTKView *)view {
    view.clearColor = [self randomColor];
    id<MTLCommandBuffer> buffer = [self.commandQueue commandBuffer];
    buffer.label = @"command buffer 1";
    
    id<MTLCommandEncoder> commandEncoder = [buffer renderCommandEncoderWithDescriptor:view.currentRenderPassDescriptor];
    [commandEncoder endEncoding];
    
    [buffer presentDrawable:view.currentDrawable];
    [buffer commit];
    
}

- (void)mtkView:(MTKView *)view drawableSizeWillChange:(CGSize)size {
    
}

- (MTLClearColor)randomColor {
    return MTLClearColorMake(((double)arc4random() / UINT32_MAX), ((double)arc4random() / UINT32_MAX), ((double)arc4random() / UINT32_MAX), 1);
}

@end
