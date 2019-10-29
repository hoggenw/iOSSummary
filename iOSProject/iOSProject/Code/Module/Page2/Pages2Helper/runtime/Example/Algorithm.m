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

-(int16_t)testInt:(int16_t)number {
    int16_t x = number;
    int16_t i = 0;
    
    while (x != 0) {
        i = i * 10 + x%10;
        x = x/10;
        NSLog(@"i = %@,x = %@",@(i),@(x));
    }
    if (i < INT16_MIN || i > INT16_MAX) {
        return 0;
    }
    return  i;
}

-(NSMutableArray<NSNumber *> *)bubbleSortTest:(NSMutableArray<NSNumber *> *)tempArray {
    for (int i = 0; i < tempArray.count-1; i++) {
        bool isSorted = true  ;
        for (int j = 0; j < tempArray.count - i -1; j++) {
            if (tempArray[j].integerValue > tempArray[j + 1].integerValue) {
                NSNumber * mid = tempArray[j];
                tempArray[j] = tempArray[j + 1] ;
                tempArray[j + 1] = mid;
                isSorted = false;
            }
        }
        if (isSorted) {
            break;
        }
    }
    return tempArray;
}

-(NSMutableArray<NSNumber *> *)selectSortTest:(NSMutableArray<NSNumber *> *)tempArray{
    for (int i = 0; i < tempArray.count-1; i++) {
        for (int j = i+1; j < tempArray.count ; j++) {
            if (tempArray[i].integerValue > tempArray[j].integerValue) {
                NSNumber * mid = tempArray[i];
                tempArray[i] = tempArray[j] ;
                tempArray[j] = mid;
                
            }
        }
    }
    return tempArray;
}

-(int)findIndex:(NSMutableArray<NSNumber *> *)tempArray  value:(NSNumber *)number {
    int min = 0;
    int max = (int)tempArray.count - 1;
    int mid;
    int count = 0;
    while (min <= max) {
        count ++;
        mid = (min + max)/2;
        if (number.integerValue > tempArray[mid].integerValue) {
            min = mid + 1;
        } else if (number.integerValue < tempArray[mid].integerValue) {
            max = mid - 1;
        } else {
            NSLog(@"count times : %@",@(count));
            return mid;
        }
    }
    
    return  -1;
}


-(int)findIndex:(NSMutableArray<NSNumber *> *)tempArray  value:(NSNumber *)number max:(int)max min:(int)min {
    int mid = 0;
    mid = (min + max)/2;
    _otherCount ++ ;
    if (number.integerValue > tempArray[mid].integerValue) {
        return [self findIndex:tempArray value:number max:max min:mid+1];
    } else if (number.integerValue < tempArray[mid].integerValue) {
        return [self findIndex:tempArray value:number max:mid-1 min:min];
    } else {
        return mid;
    }

    
    return  -1;
}


-(void)primeTest:(int)maxLimit {
    for (int i = 2;  i <= maxLimit; i ++) {
        if ([self isProme:i]) {
            NSLog(@"prime number : %d",i);
        }
    }
}

-(BOOL)isProme:(int)n {
    for (int i = 2; i <= sqrt(n); i ++) {
        if (n%i == 0) {
            return  false;
        }
    }
    return true;
}


@end
