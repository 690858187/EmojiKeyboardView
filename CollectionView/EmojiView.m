//
//  EmojiView.m
//  CollectionView
//
//  Created by 1234 on 16/3/15.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "EmojiView.h"
#import "Masonry.h"
@interface EmojiView ()
{
    UIImageView *emojiImageView;
}
@end

@implementation EmojiView

#pragma mark-----life cycle

- (id)initWithFrame:(CGRect)frame {
    
    if (self= [super initWithFrame:frame]) {
        
        [self setupView];
        [self layoutUI];
    }
    return self;
}

- (void)setupView {
    
    emojiImageView = [UIImageView new];
    emojiImageView.clipsToBounds = YES;
    emojiImageView.contentMode = UIViewContentModeScaleAspectFill;
    emojiImageView.userInteractionEnabled = YES;
    [self addSubview:emojiImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [emojiImageView addGestureRecognizer:tap];
}

- (void)layoutUI {
    
    [emojiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark-----Private Method

- (void)tapAction {
    if (self.eBlock) {
        self.eBlock();
    }
}

- (void)updateEmoji {
    emojiImageView.image = _emojiImage;
}

#pragma mark-----Public  Method

#pragma mark-----Notification Method

#pragma mark-----getting&&setting

- (void)setEmojiImage:(UIImage *)emojiImage {
    _emojiImage = emojiImage;
    [self updateEmoji];
}

@end
