//
//  ProductSKUView.h
//  Pods-ProductSKU_Example
//
//  Created by 王培铮 on 2019/8/27.
//

#import <UIKit/UIKit.h>

@protocol ProductSKUViewDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface ProductSKUView : UIView


/**
 item字体 默认13
 */
@property (nonatomic, strong) UIFont *itemFont;
/**
 选中item颜色 默认FF375E
 */
@property (nonatomic, strong) UIColor *selectdItemColor;
/**
 未选中item颜色 默认817F7F
 */
@property (nonatomic, strong) UIColor *unSelectedItemColor;
/**
 无货item的背景色 默认817F7F
 */
@property (nonatomic, strong) UIColor *backgroundColor;
/**
 sku标题字体 默认15
 */
@property (nonatomic, strong) UIFont *headerFont;
/**
 sku标题颜色 默认544B4C
 */
@property (nonatomic, strong) UIColor *headerColor;

/**
 按钮标题字体 默认17
 */
@property (nonatomic, strong) UIFont *sureBtnTitleFont;

/**
 按钮标题颜色 默认白色
 */
@property (nonatomic, strong) UIColor *sureBtnTitleColor;

/**
 按钮背景颜色 默认FF375E
 */
@property (nonatomic, strong) UIColor *sureBtnBackgroundColor;
/**
 sku头部视图
 */
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic,weak) id<ProductSKUViewDelegate> delegate;

- (void)showWithDataSource:(NSArray *)dataSource skuArray:(NSArray *)skuArray selectedIndexPaths:(nullable NSMutableSet <NSIndexPath *>*)selectedIndexPaths;

- (void)dismiss;

@end


@protocol ProductSKUViewDelegate <NSObject>

- (void)SelectSKUViewDidSelectIndexPaths:(NSMutableArray <NSIndexPath *>*)selectedIndexPaths result:(NSDictionary *)result;

- (void)selectProductWithNotSure:(id)product;

@end

NS_ASSUME_NONNULL_END
