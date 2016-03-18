//
//  EmojiKeyboardInputView.h
//  CollectionView
//
//  Created by 1234 on 16/3/16.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmojiKeyboardInputViewDelegate <NSObject>
/** 点击笑脸按钮*/
- (void)emojiKeyboardInputViewdidSelectSmileButtonAction;
/** 点击发送按钮*/
- (void)emojiKeyboardInputViewdidSelectGiftButtonAction;
/** 发送message*/
- (void)emojiKeyboardInputViewdidSelectAddsendMessageButton;
@end

@interface EmojiKeyboardInputView : UIView
@property (nonatomic, weak)id<EmojiKeyboardInputViewDelegate> delegate;
@property (nonatomic, copy)void (^sTextBeginEditBlock)();
@property (nonatomic, strong) UIImage *touchEmojiImage;
@end
