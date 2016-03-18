//
//  EmojiKeyboardInputTextView.h
//  EmojiKeyboardView
//
//  Created by 1234 on 16/3/17.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmojiKeyboardInputTextView : UITextView
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) void (^sSendBlock)();
- (void)showPlaceholder;
- (void)hidePlaceholder;
@end
