//
//  ChatOtherUserModel.h
//  YLScoketTest
//
//  Created by 王留根 on 2018/1/23.
//  Copyright © 2018年 ios-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  ChatUserModel;

@interface ChatOtherUserModel : NSObject

+(instancetype)sharedOtherUser;

@property (nonatomic, strong) ChatUserModel *user;

@end
