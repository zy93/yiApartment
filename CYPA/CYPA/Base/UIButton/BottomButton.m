//
//  BottomButton.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/5.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "BottomButton.h"
#import "Header.h"
@implementation BottomButton

-(instancetype)init{
    
    if (self == [super init]) {
        
        self.backImv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.backImv.image = [UIImage imageNamed:@"975"];
        //        self.backImv.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.backImv];
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self.imageView addSubview:self.textLabel];


    }
    return self;
    
}


@end
