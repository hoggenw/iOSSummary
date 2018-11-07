//
//  UtilsHeader.h
//  FTXExperienceStore
//
//  Created by 王留根 on 2018/1/10.
//  Copyright © 2018年 hoggen. All rights reserved.
//

#ifndef UtilsHeader_h
#define UtilsHeader_h

#import "YLDeviceUtil.h"
#import "UserDefUtils.h"


@protocol ActionSelcetControlDelegate <NSObject>

- (void) buttonAction: (NSInteger )index;

@end


@protocol NormalActionWithInfoDelegate <NSObject>

- (void)actionWithInfo:(id )obj;

@end

typedef NS_ENUM(NSInteger, CellType){
    Default = 0,
    VoteStyle = 1,
    HouseStyle = 2,
    HouseDetailStyle = 3,
    HouseItemStyle = 4,
    CouncilVoteStyle = 5,
};

typedef NS_ENUM(NSInteger, PopupViewType){
    DefaultStyle  = 0,
    VoteInfoStyle = 1,
    ProjectInfoStyle = 2,
    CoucilVoteStyle = 3,
};
#endif /* UtilsHeader_h */
