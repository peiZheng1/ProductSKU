//
//  ProductSKUCollectionCell.m
//  Pods-ProductSKU_Example
//
//  Created by 王培铮 on 2019/8/27.
//

#import "ProductSKUCollectionCell.h"

#import <Masonry/Masonry.h>

@implementation ProductSKUCollectionCell

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _skuLabel = [[UILabel alloc] init];
        _skuLabel.layer.cornerRadius = 4;
        _skuLabel.layer.borderWidth = 1;
        _skuLabel.textAlignment = NSTextAlignmentCenter;
        _skuLabel.layer.masksToBounds = YES;
        [self addSubview:_skuLabel];
        [_skuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.equalTo(self);
        }];
        
    }
    return self;
}

@end
