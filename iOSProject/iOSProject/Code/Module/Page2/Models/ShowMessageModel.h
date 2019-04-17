//
//  ShowMessageModel.h
//  iOSProject
//
//  Created by 王留根 on 2019/4/16.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    TextType,
    ImageType,
    Other,
} ShowMessageType;


@interface ShowMessageModel : NSObject

@property (nonatomic, copy) NSString * content;
@property (nonatomic, assign) ShowMessageType showType;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, copy) NSString * boldString;

@end

NS_ASSUME_NONNULL_END
