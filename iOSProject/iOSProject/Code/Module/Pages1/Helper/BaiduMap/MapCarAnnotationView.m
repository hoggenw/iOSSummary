//
//  MapCarAnnotationView.m
//  iOSProject
//
//  Created by 王留根 on 2019/1/12.
//  Copyright © 2019 hoggenWang.com. All rights reserved.
//

#import "MapCarAnnotationView.h"

@implementation MapCarAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self =  [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layer.masksToBounds = NO;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
