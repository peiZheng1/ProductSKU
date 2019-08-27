//
//  ProductSKUView.m
//  Pods-ProductSKU_Example
//
//  Created by 王培铮 on 2019/8/27.
//

#import "ProductSKUView.h"

#import <Masonry/Masonry.h>


#import "ProductSKUDataFilter.h"
#import "ProductSKUHeaderView.h"
#import "ProductSKUCollectionCell.h"

//屏幕宽/高
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
// device height
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
//横向间隔根据比例自适应
#define PPIWIDTH(value) value*[UIScreen mainScreen].bounds.size.width/375

#define KIsiPhoneX ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? YES : NO)

#define ColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ProductSKUView () <UICollectionViewDataSource, UICollectionViewDelegate, ProductSKUDataFilterDataSource>

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, strong) UIView *skuBackgroundView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) ProductSKUDataFilter *filter;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSArray *skuData;

@property (nonatomic, assign) BOOL autoLayoutFlag;

@property (nonatomic, assign) CGFloat skuBackgroundViewHeight;

/**
 确定按钮
 */
@property (nonatomic, strong) UIButton *sureBtn;

@end

@implementation ProductSKUView

- (void)resetConfig {
    _skuBackgroundViewHeight = 0;
    _autoLayoutFlag = NO;
    _itemFont = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    _selectdItemColor = ColorFromRGB(0xFF375E);
    _unSelectedItemColor = ColorFromRGB(0x817F7F);
    _backgroundColor = ColorFromRGB(0x817F7F);
    _headerFont = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    _headerColor = ColorFromRGB(0x544B4C);
    
    _sureBtnTitleFont = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    _sureBtnTitleColor = [UIColor whiteColor];
    _sureBtnBackgroundColor = ColorFromRGB(0xFF375E);
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self resetConfig];
        
        
        
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.7;
        [self addSubview:_backgroundView];
        [_backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self);
        }];
        
        
        
        _skuBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
        _skuBackgroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_skuBackgroundView];
        
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_skuBackgroundView addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self->_skuBackgroundView).offset(KIsiPhoneX ? -34 : 0);
            make.left.right.equalTo(self->_skuBackgroundView);
            make.height.mas_equalTo(50);
        }];
        
        
        
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(PPIWIDTH(50), PPIWIDTH(30));
        flowLayout.minimumInteritemSpacing = PPIWIDTH(14);
        flowLayout.minimumLineSpacing = PPIWIDTH(14);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGFLOAT_MAX) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ProductSKUCollectionCell class] forCellWithReuseIdentifier:@"ProductSKUCollectionCell"];
        [_collectionView registerClass:[ProductSKUHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProductSKUHeaderView"];
        _collectionView.scrollEnabled = NO;
        [_skuBackgroundView addSubview:_collectionView];
        
    }
    
    return self;
}


#pragma mark -- collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataSource.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        ProductSKUHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProductSKUHeaderView" forIndexPath:indexPath];
        headerView.titleLabel.text = _dataSource[indexPath.section][@"name"];
        reusableview = headerView;
    }
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake(SCREEN_WIDTH - PPIWIDTH(30) , 20 + PPIWIDTH(5));
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataSource[section][@"value"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductSKUCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductSKUCollectionCell" forIndexPath:indexPath];
    NSArray *data = _dataSource[indexPath.section][@"value"];
    cell.skuLabel.text = data[indexPath.row];
    
    cell.skuLabel.font = _itemFont;
    
    if ([_filter.availableIndexPathsSet containsObject:indexPath]) {
        cell.skuLabel.textColor = _unSelectedItemColor;
        cell.skuLabel.backgroundColor = [UIColor whiteColor];
        cell.skuLabel.layer.borderColor = _unSelectedItemColor.CGColor;
        cell.userInteractionEnabled = YES;
    } else {
        cell.skuLabel.textColor = [UIColor whiteColor];
        cell.skuLabel.backgroundColor = _backgroundColor;
        cell.skuLabel.layer.borderColor = _backgroundColor.CGColor;
        cell.userInteractionEnabled = NO;
    }
    
    if ([_filter.selectedIndexPaths containsObject:indexPath]) {
        cell.skuLabel.textColor = _selectdItemColor;
        cell.skuLabel.backgroundColor = [UIColor whiteColor];
        cell.skuLabel.layer.borderColor = _selectdItemColor.CGColor;
        cell.userInteractionEnabled = NO;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSArray *data = _dataSource[indexPath.section][@"value"];
    return CGSizeMake([self getLabelString:data[indexPath.row] font:_itemFont] + PPIWIDTH(13), PPIWIDTH(30));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [_filter didSelectedPropertyWithIndexPath:indexPath];
    
    [collectionView reloadData];
    [self reSetView];
}

#pragma mark -- ProductSKUDataFilterDataSource

- (NSInteger)numberOfSectionsForPropertiesInFilter:(ProductSKUDataFilter *)filter {
    return _dataSource.count;
}

- (NSArray *)filter:(ProductSKUDataFilter *)filter propertiesInSection:(NSInteger)section {
    return _dataSource[section][@"value"];
}

- (NSInteger)numberOfConditionsInFilter:(ProductSKUDataFilter *)filter {
    return _skuData.count;
}

- (NSArray *)filter:(ProductSKUDataFilter *)filter conditionForRow:(NSInteger)row {
    NSString *condition = _skuData[row][@"contition"];
    return [condition componentsSeparatedByString:@","];
}

- (id)filter:(ProductSKUDataFilter *)filter resultOfConditionForRow:(NSInteger)row {
    
    return  _skuData[row];
}

- (void)reSetView {
    id nowResult = self.filter.currentResult;
    if (nowResult == nil) {
        return;
    }
    
    id model = [nowResult objectForKey:@"sku"];
    if (model == nil) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(selectProductWithNotSure:)]) {
        [self.delegate selectProductWithNotSure:model];
    }
}




- (CGFloat)getLabelString:(NSString *)string font:(UIFont *)font {
    
    CGRect titleeSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:0 attributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, [UIColor blackColor], NSForegroundColorAttributeName, nil ] context:nil];
    return titleeSize.size.width;
}



#pragma mark - publicFuncation
- (void)showWithDataSource:(NSArray *)dataSource skuArray:(NSArray *)skuArray selectedIndexPaths:(nullable NSMutableSet <NSIndexPath *>*)selectedIndexPaths {
    
    _filter = [[ProductSKUDataFilter alloc] initWithDataSource:self];
    self.dataSource = dataSource;
    self.skuData = skuArray;
    
    if (selectedIndexPaths == nil) {
        _filter.needDefaultValue = YES;
    } else {
        _filter.selectedIndexPaths = selectedIndexPaths;
    }
    
    [self.collectionView reloadData];
    [self reSetView];
    
    
    if (!_autoLayoutFlag) {
        
        _autoLayoutFlag = YES;
        
        [_skuBackgroundView addSubview:_headerView];
        
        _skuBackgroundViewHeight = self.headerView.frame.size.height + 50 + _collectionView.collectionViewLayout.collectionViewContentSize.height + (KIsiPhoneX ? 34 : 0) + PPIWIDTH(20);
        _skuBackgroundView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, _skuBackgroundViewHeight);
        
        _sureBtn.backgroundColor = _sureBtnBackgroundColor;
        [_sureBtn setTitleColor:_sureBtnTitleColor forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = _sureBtnTitleFont;
       
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_skuBackgroundView).offset(PPIWIDTH(15));
            make.right.equalTo(self->_skuBackgroundView).offset(-PPIWIDTH(15));
            make.top.equalTo(self->_headerView.mas_bottom).offset(PPIWIDTH(10));
            make.bottom.equalTo(self->_sureBtn.mas_top).offset(-PPIWIDTH(10));
        }];
    }
    
    
    
    self.frame = [[UIApplication sharedApplication].delegate window].bounds;
    self.backgroundView.alpha = 0.0;
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.backgroundView.alpha = 0.8;
        weakSelf.skuBackgroundView.frame = CGRectMake(0, SCREEN_HEIGHT - self->_skuBackgroundViewHeight, SCREEN_WIDTH, self->_skuBackgroundViewHeight);
    }];
    
}

- (void)dismiss {
    typeof(self) __weak weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.backgroundView.alpha = 0.0;
        weakSelf.skuBackgroundView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self->_skuBackgroundViewHeight);
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

- (void)sureBtnClick {
    if ([self.delegate respondsToSelector:@selector(SelectSKUViewDidSelectIndexPaths:result:)]) {
        [self.delegate SelectSKUViewDidSelectIndexPaths:self.filter.selectedIndexPaths result:self.filter.currentResult];
    }
    [self dismiss];
}


@end
