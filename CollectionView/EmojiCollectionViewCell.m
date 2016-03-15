//
//  EmojiCollectionViewCell.m
//  CollectionView
//
//  Created by 1234 on 16/3/14.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "EmojiCollectionViewCell.h"

@interface EmojiCollectionViewCell ()
{
    UIImageView *imageView;
}
@end

@implementation EmojiCollectionViewCell
#pragma mark-----life cycle

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupView];
        [self layoutUI];
    }
    return self;
}

- (void)setupView {
    
    imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"233.png"];
    imageView.frame = CGRectMake(0, 0, 30, 30);
    [self.contentView addSubview:imageView];
}

- (void)layoutUI {
    
}

- (void)setImage:(UIImage *)image {
    _image = image;
    imageView.image = image;
}

#pragma mark-----Private Method

#pragma mark-----Public  Method

#pragma mark-----Notification Method
@end
