//
//  YLPlayerOption.m
//  iOSProject
//
//  Created by 王留根 on 2019/9/10.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "YLPlayerOption.h"

@implementation YLPlayerOption

-(YLInterfaceOrientationType)getCurrentScreenDirection
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationLandscapeRight) // home键靠右
    {
        return YLInterfaceOrientationLandscapeRight;
    }
    
    if (orientation ==UIInterfaceOrientationLandscapeLeft) // home键靠左
    {
        return YLInterfaceOrientationLandscapeLeft;
    }
    if (orientation == UIInterfaceOrientationPortrait)
    {
        
        return YLInterfaceOrientationPortrait;
    }
    if (orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        return YLInterfaceOrientationPortraitUpsideDown;
    }
    return YLInterfaceOrientationUnknown;
    
}

@end
