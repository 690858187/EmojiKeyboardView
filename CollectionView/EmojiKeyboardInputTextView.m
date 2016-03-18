//
//  EmojiKeyboardInputTextView.m
//  EmojiKeyboardView
//
//  Created by 1234 on 16/3/17.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "EmojiKeyboardInputTextView.h"
#import "Masonry.h"
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
    self.textColor = [UIColor colorWithRed:142.0/255 green:142.0/255 blue:142.0/255 alpha:1];
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
    
    
    //    self.textField.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1];
    //    self.textField.textColor = [UIColor colorWithRed:142.0/255 green:142.0/255 blue:142.0/255 alpha:1];
    //    self.textField.layer.borderColor = [UIColor colorWithRed:198.0/255 green:198.0/255 blue:198.0/255 alpha:1].
    // [UIColor colorWithRed:142.0/255 green:142.0/255 blue:142.0/255 alpha:1]
    self.senderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [ self.senderButton setTitle:@"发送" forState:UIControlStateNormal];
    [ self.senderButton setTitleColor:[UIColor colorWithRed:142.0/255 green:142.0/255 blue:142.0/255 alpha:1] forState:UIControlStateNormal];
     self.senderButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [ self.senderButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.senderButton];
    
}

- (void)layoutUI {
    
    [self.placeholderLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self);
        make.left.equalTo(self).offset(5);
        make.right.equalTo(self.senderButton.mas_left);
    }];
    
    [self.senderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.width.equalTo(@40);
        make.centerY.height.equalTo(self);
    }];
}

- (void)addObserver {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextDidBeginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextDidBeginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextDidBeginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
}

- (void)sendButtonAction {
    
}

//#pragma mark-----UITextViewDelegate
//
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//    return YES;
//}
//
//- (void)textViewDidChange:(UITextView *)textView {
//    
//}

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
