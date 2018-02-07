//
//  UIImage+RXSDK.m
//  RXSDK
//
//  Created by Rush.D.Xzj on 07/02/2018.
//  Copyright © 2018 TAL. All rights reserved.
//

#import "UIImage+RXSDK.h"

@implementation UIImage (RXSDK)

+ (UIImage *)rxsdk_imageInBundle:(NSString *)imageName
{
    NSString *name = [@"Frameworks/RXSDK.framework/RXSDK.bundle" stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageNamed:name];
    return image;
}
@end
