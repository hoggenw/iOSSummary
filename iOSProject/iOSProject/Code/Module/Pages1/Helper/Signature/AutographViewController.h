//
//  AutographViewController.h
//  Vote
//
//  Created by 王留根 on 2018/7/25.
//  Copyright © 2018年 OwnersVote. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutographViewController : UIViewController

@property(nonatomic,strong)NSString *pictureUrl;

/** 签名完成回调 */
@property (nonatomic, copy) void (^signatureFishBlock)(UIImage * image);

@end
