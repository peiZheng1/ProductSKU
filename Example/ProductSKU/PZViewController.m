//
//  PZViewController.m
//  ProductSKU
//
//  Created by peiZheng1 on 08/27/2019.
//  Copyright (c) 2019 peiZheng1. All rights reserved.
//

#import "PZViewController.h"

#import "ProductSKUView.h"

@interface PZViewController () <ProductSKUViewDelegate>

@property (nonatomic, strong) ProductSKUView *skuView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSMutableSet *selectedIndexPaths;

@property (nonatomic, strong) NSArray *skuData;


@end

@implementation PZViewController
- (NSArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = @[
                        @{
                            @"name":@"内存",
                            @"value":@[
                                    @"64G",@"256G"
                                    ]
                            },
                        @{
                            @"name":@"颜色",
                            @"value":@[
                                    @"深空灰",@"红色特别版",@"银色"
                                    ]
                            }
                        ];
    }
    return _dataSource;
}

- (NSArray *)skuData {
    if (_skuData == nil) {
        _skuData = @[
                     @{
                         @"contition":@"64G,深空灰",
                         @"price":@"1000",
                         @"store":@"11",
                         @"sku":@{
                                 @"haha":@"64G深空灰"
                                 }
                         },
                     @{
                         @"contition":@"64G,红色特别版",
                         @"price":@"1500",
                         @"store":@"11",
                         @"sku":@{
                                 @"haha":@"64G红色特别版"
                                 }
                         },
                     @{
                         @"contition":@"256G,银色",
                         @"price":@"3000",
                         @"store":@"11",
                         @"sku":@{
                                 @"haha":@"256G银色"
                                 }
                         },
                     @{
                         @"contition":@"256G,红色特别版",
                         @"price":@"3000",
                         @"store":@"11",
                         @"sku":@{
                                 @"haha":@"256G红色特别版"
                                 }
                         },
                     ];
    }
    return _skuData;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 90, 40, 30)];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    
    self.selectedIndexPaths = nil;
    _skuView = [[ProductSKUView alloc] initWithFrame:CGRectZero];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
    topView.backgroundColor = [UIColor orangeColor];
    _skuView.headerView = topView;
    
    
    
    _skuView.delegate = self;
}

- (void)btnClick {
    [self.skuView showWithDataSource:self.dataSource skuArray:self.skuData selectedIndexPaths:self.selectedIndexPaths];
}


- (void)SelectSKUViewDidSelectIndexPaths:(NSMutableSet <NSIndexPath *>*)selectedIndexPaths result:(NSDictionary *)result {
    self.selectedIndexPaths = selectedIndexPaths;
}

- (void)selectProductWithNotSure:(id)product {
    
}
@end
