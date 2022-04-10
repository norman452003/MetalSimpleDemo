//
//  ViewController.m
//  MetalDemo
//
//  Created by gx on 2022/4/10.
//

#import "ViewController.h"
#import "KSRender.h"
#import <MetalKit/MetalKit.h>

@interface ViewController ()

@property (nonatomic,strong) MTKView *mtkView;

@property (nonatomic,strong) KSRender *render;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.mtkView];
}

- (MTKView *)mtkView {
    if (_mtkView == nil) {
        _mtkView = [[MTKView alloc] initWithFrame:self.view.frame device:MTLCreateSystemDefaultDevice()];
        _mtkView.preferredFramesPerSecond = 1;
        _render = [[KSRender alloc] initWithMTKView:_mtkView];
        _mtkView.delegate = _render;
    }
    return _mtkView;
}

@end
