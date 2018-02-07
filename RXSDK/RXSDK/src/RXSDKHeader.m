//
//  RXSDKHeader.m
//  RXSDK
//
//  Created by Rush.D.Xzj on 07/02/2018.
//  Copyright © 2018 TAL. All rights reserved.
//

#import "RXSDKHeader.h"

#import "RXSDKView.h"

@implementation RXSDK

+ (UIView *)rxsdkView
{
    return [RXSDKView defaultView];
}
@end
