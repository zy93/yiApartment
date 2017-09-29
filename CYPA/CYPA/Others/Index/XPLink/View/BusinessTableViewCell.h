//
//  BusinessTableViewCell.h
//  CYPA
//
//  Created by 黄冬冬 on 16/2/25.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^passID)();

@interface BusinessTableViewCell : UITableViewCell

@property(nonatomic,strong)passID passId;

@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UICollectionView * collectionView;



@end
