//
//  OrderDatilyViewController.m
//  CYPA
//
//  Created by 黄冬冬 on 16/3/23.
//  Copyright © 2016年 HDD. All rights reserved.
//

#import "OrderDatilyViewController.h"
#import "Header.h"

@interface OrderDatilyViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UIView * introView;
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)UILabel * sumLabel;
@property(nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation OrderDatilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeData];
    [self setupViews];
    
}
-(void)makeData {
    
    NSMutableDictionary * dictory = [NSMutableDictionary dictionary];
    [dictory setValue:[NSString stringWithFormat:@"%d", self.orderID] forKey:@"OrderID"];
    
    [[GXNetWorkManager shareInstance] getInfoWithInfo:dictory path:@"/order/listOrderProduct" success:^(NSMutableDictionary * dict) {
        if ([dict[@"code"] isEqualToString:@"0"]) {
            
            for (NSDictionary * dic in dict[@"data"]) {
                OrderModel *model = [OrderModel new];
                [model setValuesForKeysWithDictionary:dic];
                
                [self.dataArray addObject:model];
            }
            
            [self.tableView reloadData];
            
        }else{
            [self showAlertWithString:dict[@"message"]];
        }
        
    } failed:^{
        
        [self showAlertWithString:@"错误"];
    }];
    
    
}

-(void)topView{
    //商品详情view
    _introView = [[UIView alloc] init];
    _introView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_introView];
    [_introView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleImv.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(42.5));
    }];
    
    //商品名称
    UILabel * nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"商品名称";
    nameLabel.textColor = [UIColor colorWithHexString:@"333333"];
    //    _pricelabel = [UIColor yellowColor];
    [_introView addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_introView.mas_centerY);
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //价格
    UILabel * priceLabel = [[UILabel alloc] init];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = [UIColor colorWithHexString:@"333333"];
    priceLabel.text = @"价格";
    //    _pricelabel = [UIColor yellowColor];
    [_introView addSubview:priceLabel];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_introView.mas_centerY);
        make.left.mas_equalTo(nameLabel.mas_right).offset(SIZE_SCALE_IPHONE6(50));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //数量
    UILabel * numberLabel = [[UILabel alloc] init];
    numberLabel.font = [UIFont systemFontOfSize:15];
    numberLabel.text = @"数量";
    numberLabel.textColor = [UIColor colorWithHexString:@"333333"];
    //    _pricelabel = [UIColor yellowColor];
    [_introView addSubview:numberLabel];
    
    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_introView.mas_centerY);
        make.left.mas_equalTo(priceLabel.mas_right).offset(SIZE_SCALE_IPHONE6(60));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
    
    //合计
    UILabel * totalLabel = [[UILabel alloc] init];
    totalLabel.font = [UIFont systemFontOfSize:15];
    totalLabel.textColor = [UIColor colorWithHexString:@"333333"];
    totalLabel.text = @"合计";
    //    _pricelabel = [UIColor yellowColor];
    [_introView addSubview:totalLabel];
    
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_introView.mas_centerY);
        make.right.mas_equalTo(SIZE_SCALE_IPHONE6(-30));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(15));
    }];
}

-(void)setupViews{
    [self topView];
    
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[OutletsProductTableViewCell class] forCellReuseIdentifier:@"CELL"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_introView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.frame = CGRectMake(0, 0, self.view.frame.size.width, SIZE_SCALE_IPHONE6(660));
    
    self.tableView.tableFooterView = bottomView;
    
    //总费用
    self.sumLabel = [[UILabel alloc] init];
    self.sumLabel.text = [NSString stringWithFormat:@"共计金额：%.1f", self.sumMoney];
    self.sumLabel.font = [UIFont systemFontOfSize:18];
    [bottomView addSubview:self.sumLabel];
    [self.sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.top.mas_equalTo(SIZE_SCALE_IPHONE6(15));
        make.height.mas_equalTo(SIZE_SCALE_IPHONE6(18));
    }];
    
    
}



//tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OutletsProductTableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    OrderModel * model = self.dataArray[indexPath.section];
    
    [cell.productImv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseImageURL,model.PicPath]] placeholderImage:[UIImage imageNamed:placeholdPicture]];
    cell.proNameLabel.text = model.ProName;
    cell.realPriceLabel.text = [NSString stringWithFormat:@"%.1f",model.RealPrice];
//    cell.UnitLabel.text = model.Unit;
    cell.UnitLabel.text = @"元";
    cell.addBT.hidden = YES;
    cell.reduceBT.hidden = YES;
    cell.numberTF.backgroundColor = [UIColor whiteColor];
    cell.numberTF.text = [NSString stringWithFormat:@"%d",model.Number];

    cell.totalLabel.text = [NSString stringWithFormat:@"%.1f元", model.RealPrice*model.Number];
    
    return cell;
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return SIZE_SCALE_IPHONE6(90);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
