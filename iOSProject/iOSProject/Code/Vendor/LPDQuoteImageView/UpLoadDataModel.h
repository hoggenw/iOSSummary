//
//  UpLoadDataModel.h
//  AFNetworking
//
//  Created by 王留根 on 2018/6/26.
//

#import <Foundation/Foundation.h>

@interface UpLoadDataModel : NSObject

@property (nonatomic, strong)NSData * data;
@property (nonatomic, copy) NSString * dataType;
@property (nonatomic, copy) NSString * showName;
@property (nonatomic, copy) NSURL * url;

@end
