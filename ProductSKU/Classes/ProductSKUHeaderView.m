//
//  ProductSKUHeaderView.m
//  Masonry
//
//  Created by 王培铮 on 2019/8/27.
//

#import "ProductSKUHeaderView.h"

#import <Masonry/Masonry.h>

@implementation ProductSKUHeaderView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
        }];
    }
    return self;
}


@end
