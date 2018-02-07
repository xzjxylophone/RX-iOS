//
//  RXSDKView.m
//  RXSDK
//
//  Created by Rush.D.Xzj on 07/02/2018.
//  Copyright © 2018 TAL. All rights reserved.
//

#import "RXSDKView.h"
#import "UIImage+RXSDK.h"
@interface RXSDKView()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation RXSDKView

- (id)initWithFrame:(CGRect)frame
{
    CGFloat width = 100;
    CGFloat height = 100;
    if (self = [super initWithFrame:CGRectMake(0, 0, width, height)]) {
        
        UIImage *image = [UIImage rxsdk_imageInBundle:@"rx_icon_star_orange"];
        self.imageView = [[UIImageView alloc] initWithImage:image];
        self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        
        [self addSubview:self.imageView];
        self.backgroundColor = [UIColor redColor];
        
        
    }
    return self;
}

+ (id)defaultView
{
    return [[RXSDKView alloc] initWithFrame:CGRectZero];
}

@end
