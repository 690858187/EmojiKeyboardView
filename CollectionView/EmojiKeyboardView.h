//
//  EmojiKeyboardView.h
//  CollectionView
//
//  Created by 1234 on 16/3/16.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    EmojiKeyboardViewStateA = 0,    //默认为表情键盘全部弹出
    EmojiKeyboardViewStateB,        //仅表情键盘输入框弹出
    EmojiKeyboardViewStateC,        //表情键盘输入框隐藏
} EmojiKeyboardViewState;

@interface EmojiKeyboardView : UIView
@property (nonatomic, assign) EmojiKeyboardViewState keyboardViewState;

/**
 *  在某个view中加入键盘
 *
 *  @param view view
 */

+ (void)addEmojiKeyboardViewOnSuperView:(UIView *)view;

/**
 *  控制展示键盘的方式
 *
 *  @param keyboardViewState 键盘展示的类型
 */

+ (void)showEmojiKeyBoardViewWithKeyboardViewState:(EmojiKeyboardViewState)keyboardViewState;
@end
