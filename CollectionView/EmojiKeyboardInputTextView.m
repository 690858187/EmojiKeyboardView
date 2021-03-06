//
//  EmojiKeyboardInputTextView.m
//  EmojiKeyboardView
//
//  Created by 1234 on 16/3/17.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "EmojiKeyboardInputTextView.h"
#import "Masonry.h"
#define EmojiInputView_Height    54                                     //输入框的高度
@interface EmojiKeyboardInputTextView ()<UITextViewDelegate>

@property (nonatomic, strong) UIButton *senderButton;
@property (nonatomic, strong) UILabel *placeholderLable;

@end

@implementation EmojiKeyboardInputTextView

- (id)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        
        [self setupView];
        [self layoutUI];
        [self addObserver];
        self.delegate = self;
    }
    return self;
}

- (void)setupView {
    
    self.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1];
    self.textColor = [UIColor blackColor];
    self.layer.borderColor = [UIColor colorWithRed:198.0/255 green:198.0/255 blue:198.0/255 alpha:1].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 2;
    self.font = [UIFont systemFontOfSize:13];
    self.delegate = self;
    self.placeholder = @"说点什么吧！";
    
    self.placeholderLable = [UILabel new];
    self.placeholderLable.text = self.placeholder;
    self.placeholderLable.font = [UIFont systemFontOfSize:13];
    self.placeholderLable.textColor = [UIColor colorWithRed:142.0/255 green:142.0/255 blue:142.0/255 alpha:1];
    [self addSubview:self.placeholderLable];
        
}

- (void)layoutUI {

    [self.placeholderLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self);
    }];
    
}

- (void)addObserver {

}

- (void)sendButtonAction {
    
}

#pragma mark-----Private Method

#pragma mark-----Public  Method

- (void)showPlaceholder {
   self.placeholderLable.hidden = NO;
}
- (void)hidePlaceholder {
    self.placeholderLable.hidden = YES;
}

#pragma mark-----Notification Method

@end
