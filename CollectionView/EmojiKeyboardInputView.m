//
//  EmojiKeyboardInputView.m
//  CollectionView
//
//  Created by 1234 on 16/3/16.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "EmojiKeyboardInputView.h"
#import "EmojiKeyboardInputTextView.h"
#import "Masonry.h"
#define EmojiInputView_Height    54                                     //输入框的高度
@interface EmojiKeyboardInputView ()<UITextViewDelegate>

@property (nonatomic, strong) UIButton *smileButton;
@property (nonatomic, strong) EmojiKeyboardInputTextView *keyboardInputTextView;
@property (nonatomic, strong) UIView *lineView_1;
@property (nonatomic, strong) UIView *lineView_2;
@property (nonatomic, strong) UIButton *senderButton;
@property (nonatomic, strong) UIButton *giftButton;

@end

@implementation EmojiKeyboardInputView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
        [self layoutUI];
        [self addObserver];
    }
    return self;
}

- (void)setupView {
    
    self.smileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.smileButton setImage:[UIImage imageNamed:@"233"] forState:UIControlStateNormal];
    [self.smileButton addTarget:self action:@selector(smileButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.smileButton];
    
    self.giftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.giftButton setImage:[UIImage imageNamed:@"233"] forState:UIControlStateNormal];
    [self.giftButton addTarget:self action:@selector(giftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.giftButton];

    
    
    self.keyboardInputTextView = [EmojiKeyboardInputTextView new];
    self.keyboardInputTextView.delegate = self;
    [self addSubview:self.keyboardInputTextView];
    
    self.senderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.senderButton.layer.cornerRadius = 2;
    self.senderButton.layer.borderWidth = 0.5;
    self.senderButton.backgroundColor = [UIColor colorWithRed:246.0/255 green:246.0/255 blue:246.0/255 alpha:1];
    self.senderButton.layer.borderColor = [UIColor colorWithRed:198.0/255 green:198.0/255 blue:198.0/255 alpha:1].CGColor;
    [ self.senderButton setTitle:@"发送" forState:UIControlStateNormal];
    [ self.senderButton setTitleColor:[UIColor colorWithRed:142.0/255 green:142.0/255 blue:142.0/255 alpha:1] forState:UIControlStateNormal];
    self.senderButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [ self.senderButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.senderButton];

    
    
    for (int i=0;i<2; i++) {
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor colorWithRed:198.0/255 green:198.0/255 blue:198.0/255 alpha:1];
        [self addSubview:lineView];
        switch (i) {
            case 0:
            {
                self.lineView_1 = lineView;
            }
                break;
            case 1:
            {
                self.lineView_2 = lineView;
            }
                break;

                
            default:
                break;
        }
    }
}

- (void)layoutUI {
    
    CGFloat spaching = 5.0f;
    
    [self.smileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(spaching);
        make.width.height.equalTo(@(EmojiInputView_Height*6/8));
    }];
    
    [self.giftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-spaching);
        make.width.height.equalTo(@(EmojiInputView_Height*6/8));
    }];
    
    [self.senderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.giftButton.mas_left).offset(-2*spaching);
        make.width.equalTo(@40);
        make.centerY.height.equalTo(self.keyboardInputTextView);
    }];
    
    [self.keyboardInputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smileButton.mas_right).offset(spaching);
        make.centerY.equalTo(self);
        make.height.equalTo(@(EmojiInputView_Height*5/8));
        make.right.equalTo(self.senderButton.mas_left).offset(1);
    }];
    
    [self.lineView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@0.5);
    }];
    
    [self.lineView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@0.5);
    }];
    
}

- (void)addObserver {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextViewTextDidChange) name:UITextViewTextDidChangeNotification object:self.keyboardInputTextView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextDidEndEditing) name:UITextViewTextDidEndEditingNotification object:self.keyboardInputTextView];
}

#pragma mark-----Private Method

/**
 *  点击笑脸按钮
 */

- (void)smileButtonAction {
    
    if ([self.delegate respondsToSelector:@selector(emojiKeyboardInputViewdidSelectSmileButtonAction)]) {
        [self.delegate emojiKeyboardInputViewdidSelectSmileButtonAction];
    }
}

/**
 *  点击发送按钮
 */

- (void)sendButtonAction {
    if ([self.delegate respondsToSelector:@selector(emojiKeyboardInputViewdidSelectAddsendMessageButton)]) {
        [self.delegate emojiKeyboardInputViewdidSelectAddsendMessageButton];
    }
    
    UIAlertController *alertVC =[UIAlertController alertControllerWithTitle:@"" message:@"信息已发送" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *determineAlertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:determineAlertAction];
    [[self getCurrentVC] presentViewController:alertVC animated:YES completion:nil];
    
    [self.keyboardInputTextView showPlaceholder];
    self.keyboardInputTextView.text = nil;
}

/**
 *  点击礼物按钮
 */

- (void)giftButtonAction {
    if ([self.delegate respondsToSelector:@selector(emojiKeyboardInputViewdidSelectGiftButtonAction)]) {
        [self.delegate emojiKeyboardInputViewdidSelectGiftButtonAction];
    }
   
}

- (void)changeKeyboardInputTextView {
    
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc] initWithString:@"" attributes:nil];
    NSTextAttachment *attachment=[[NSTextAttachment alloc] initWithData:nil ofType:nil];
    UIImage *img = _touchEmojiImage;
    attachment.image = img;
    attachment.bounds = CGRectMake(0, 0, 25, 25);
    NSAttributedString *text=[NSAttributedString attributedStringWithAttachment:attachment];
    [str insertAttributedString:text atIndex:0];
    self.keyboardInputTextView.attributedText = str;
    if (![text isEqual:@""]) {
        [self.keyboardInputTextView hidePlaceholder];

    }
}

#pragma mark-----UITextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.sTextBeginEditBlock) {
        self.sTextBeginEditBlock();
    }
    [self.keyboardInputTextView hidePlaceholder];
}


#pragma mark-----Public  Method

- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


#pragma mark-----Notification Method

- (void)TextViewTextDidChange {
   
    if ([self.keyboardInputTextView.text  isEqual:@""]) {
        [self.keyboardInputTextView showPlaceholder];
    }else {
        [self.keyboardInputTextView hidePlaceholder];
    }
}

- (void)TextDidEndEditing {
    if ([self.keyboardInputTextView.text  isEqual:@""]) {
        [self.keyboardInputTextView showPlaceholder];
    }else {
        [self.keyboardInputTextView hidePlaceholder];
    }
}

#pragma mark-----getting&&setting

- (void)setTouchEmojiImage:(UIImage *)touchEmojiImage {
    _touchEmojiImage = touchEmojiImage;
    [self changeKeyboardInputTextView];
}

@end
