//
//  KSRender.h
//  MetalDemo
//
//  Created by gx on 2022/4/10.
//

#import <Foundation/Foundation.h>
#import <MetalKit/MetalKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KSRender : NSObject <MTKViewDelegate>

- (instancetype)initWithMTKView:(MTKView *)view;

@end

NS_ASSUME_NONNULL_END
