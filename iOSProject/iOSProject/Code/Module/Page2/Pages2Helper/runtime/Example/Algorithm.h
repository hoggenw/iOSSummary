//
//  Algorithm.h
//  iOSProject
//
//  Created by 王留根 on 2019/5/27.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Algorithm : NSObject

@property(nonatomic,assign)int otherCount;

-(BOOL)testArray:(NSArray<NSNumber *> *)intArray total:(int)total;


-(NSString *)testString:(NSString *)temp;

-(int16_t)testInt:(int16_t)number;

-(NSMutableArray<NSNumber *> *)bubbleSortTest:(NSMutableArray<NSNumber *> *)tempArray;

-(NSMutableArray<NSNumber *> *)selectSortTest:(NSMutableArray<NSNumber *> *)tempArray;

-(int)findIndex:(NSMutableArray<NSNumber *> *)tempArray  value:(NSNumber *)number;

-(int)findIndex:(NSMutableArray<NSNumber *> *)tempArray  value:(NSNumber *)number max:(int)max min:(int)min;

-(void)primeTest:(int)maxLimit;

@end

NS_ASSUME_NONNULL_END
