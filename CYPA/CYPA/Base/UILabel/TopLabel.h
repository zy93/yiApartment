//
//  TopLabel.h
//  CYPA
//
//  Created by 黄冬冬 on 16/3/21.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum VerticalAlignment {
    VerticalAlignmentTop = 0,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface TopLabel : UILabel
{
@private
    VerticalAlignment verticalAlignment_;
}
@property (nonatomic, assign) VerticalAlignment verticalAlignment;



@end
