//
//  Algorithm.m
//  iOSProject
//
//  Created by 王留根 on 2019/5/27.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "Algorithm.h"

@implementation Algorithm

-(BOOL)testArray:(NSArray<NSNumber *> *)intArray total:(int)total{
    BOOL result = false;
    for(int i = 0;i <intArray.count ; i++){
        int number = intArray[i].intValue;
        if (number > total) {
            continue;
        }
        NSNumber * other = [NSNumber numberWithInt:(total - number)];
        if ([intArray containsObject: other]) {
            NSInteger index = [intArray indexOfObject: other];
            result = true;
            NSLog(@"number[%@]:%@ + other[%ld]:%@ = total :%@",@(i),@(number),index,other,@(total));
            break;
        }
        
        
    }
    return  result;
}


-(NSString *)testString:(NSString *)temp {
    NSArray<NSString *> * strings = [temp componentsSeparatedByString:@" "];
    NSArray<NSString *> * tempStrings = [self reverseArray: strings];
    NSMutableString * result = [NSMutableString new];
    for(int i = 0 ; i < tempStrings.count; i ++ ){
        NSString * temp2 = tempStrings[i];
        temp2 = [self allReverse: temp2];
        [result appendString:[NSString stringWithFormat:@"%@ ",temp2]];
        
    }
    
    NSString * returnString =result;
    return  returnString;
}
- (NSString *)allReverse:(NSString *)tempString{
    NSMutableString *reverseString = [NSMutableString string];
    for (NSInteger i = tempString.length -1 ; i >= 0; i--) {
        unichar c = [tempString characterAtIndex:i];
        NSString *s = [NSString stringWithCharacters:&c length:1];
        [reverseString appendString:s];
    }
    return reverseString;
}

-(NSArray<NSString *> *)reverseArray:(NSArray<NSString *> *)array {
    NSMutableArray <NSString *> * temp = [NSMutableArray array];
    if (array.count == 1) {
        return  array;
    }
    for (long i = (array.count - 1); i >= 0;  i--) {
        NSLog(@"i = %ld",i);
        [temp addObject: array[i]];
    }
    
    return  [temp copy];
}



@end
