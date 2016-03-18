//
//  EmojiKeyboardView.m
//  CollectionView
//
//  Created by 1234 on 16/3/16.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "EmojiKeyboardView.h"
#import "EmojiKeyboardInputView.h"
#import "EmojiView.h"
#import "Masonry.h"
#define EmojiKeyboardView_Height 216+54+26                           //键盘的高度
#define Emoji_Line_Num   7    //一行的数量
#define Emoji_Column_Num 3  //一列的数量
#define EmojiPageControl_Height  20                                  //pageControl的高度
#define EmojikeyboardInputView_Height 54                             //输入框的高度
@interface EmojiKeyboardView ()<EmojiKeyboardInputViewDelegate>
@property (nonatomic, strong) NSArray *emojiPicArr;
@property (nonatomic, strong) EmojiKeyboardInputView *keyboardInputView;
@property (nonatomic, strong) EmojiView *emojiView;
@property (nonatomic, strong) EmojiKeyboardView *keyboardView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation EmojiKeyboardView

+(EmojiKeyboardView *)shareEmojiKeyboardView {
    static EmojiKeyboardView *shareKeyboardView = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareKeyboardView = [[EmojiKeyboardView alloc] init];
    });
    return shareKeyboardView;
}

+ (void)addEmojiKeyboardViewOnSuperView:(UIView *)view {
    [view addSubview:[EmojiKeyboardView shareEmojiKeyboardView].keyboardView];
    [[EmojiKeyboardView shareEmojiKeyboardView].keyboardView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.equalTo(@(EmojiKeyboardView_Height));
    }];
    
    [[EmojiKeyboardView shareEmojiKeyboardView] addkeyboardInputView];
    [[EmojiKeyboardView shareEmojiKeyboardView] addEmojiView];
    [[EmojiKeyboardView shareEmojiKeyboardView] addPageControl];
}

/**
 *  添加输入框
 */

- (void)addkeyboardInputView {
    
    [self.keyboardView addSubview:self.keyboardInputView];
    self.keyboardInputView.sTextBeginEditBlock = ^(){
        [EmojiKeyboardView showEmojiKeyBoardViewWithKeyboardViewState:EmojiKeyboardViewStateA];
    };
    [self.keyboardInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@54);
    }];
}

/**
 *   添加表情
 */

- (void)addEmojiView {
    [self.keyboardView addSubview:self.emojiView];
    __weak EmojiKeyboardView *weakSelf = self;
    self.emojiView.EmojiBlock = ^(NSInteger currentPage) {
        weakSelf.pageControl.currentPage = currentPage;
    };
    self.emojiView.touchEmojiBlock = ^(UIImage * currentEmojiImage) {
        weakSelf.keyboardInputView.touchEmojiImage = currentEmojiImage;
    };
    [self.emojiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.keyboardInputView.mas_bottom);
    }];
}

/**
 *   添加pageControl
 */

- (void)addPageControl {
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(EmojiPageControl_Height));
    }];
}

#pragma mark-----Public Method

+ (void)showEmojiKeyBoardViewWithKeyboardViewState:(EmojiKeyboardViewState)keyboardViewState {
    
    switch (keyboardViewState) {
        case 0:
        {   [EmojiKeyboardView shareEmojiKeyboardView].keyboardViewState = EmojiKeyboardViewStateA;
            [UIView animateWithDuration:0.5 animations:^{
                [EmojiKeyboardView shareEmojiKeyboardView].transform = CGAffineTransformMakeTranslation(0, 0);
            }];
        }
            break;
        case 1:
        {   [EmojiKeyboardView shareEmojiKeyboardView].keyboardViewState = EmojiKeyboardViewStateB;
            [UIView animateWithDuration:0.5 animations:^{
                [EmojiKeyboardView shareEmojiKeyboardView].transform = CGAffineTransformMakeTranslation(0,(EmojiKeyboardView_Height-EmojikeyboardInputView_Height));
            }];
        }
            break;
            
        default:
            break;
    }

}


#pragma mark-----EmojiKeyboardInputViewDelegate

/** 点击笑脸按钮*/
- (void)emojiKeyboardInputViewdidSelectSmileButtonAction {
    
    switch (self.keyboardViewState) {
        case EmojiKeyboardViewStateA:
        {
            self.keyboardViewState = 1;
           
            [UIView animateWithDuration:0.5 animations:^{
                self.transform = CGAffineTransformMakeTranslation(0,(EmojiKeyboardView_Height-EmojikeyboardInputView_Height));
            }];
        }
            break;
        case EmojiKeyboardViewStateB:
        {
            self.keyboardViewState  = 0;
            [UIView animateWithDuration:0.5 animations:^{
                self.transform = CGAffineTransformMakeTranslation(0, 0);
            }];

        }
            break;
            
        default:
            break;
    }
    
}
/** 点击发送按钮*/
- (void)emojiKeyboardInputViewdidSelectGiftButtonAction {
    
}
/** 发送message*/
- (void)emojiKeyboardInputViewdidSelectAddsendMessageButton {
    
}

#pragma mark-----getting&&setting

- (EmojiKeyboardInputView *)keyboardInputView {
    
    if (!_keyboardInputView) {
        _keyboardInputView = [[EmojiKeyboardInputView alloc] init];
        _keyboardInputView.delegate = self;
    }
    return _keyboardInputView;
}

- (EmojiView *)emojiView {
    
    if (!_emojiView) {
        _emojiView = [[EmojiView alloc] init];
    }
    return _emojiView;
}

- (EmojiKeyboardView *)keyboardView {
    
    if (!_keyboardView) {
        _keyboardView = [EmojiKeyboardView shareEmojiKeyboardView];
    }
    return _keyboardView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        NSInteger emojiNum = self.emojiPicArr.count;    //表情数量
        NSInteger onePageNum = Emoji_Line_Num*Emoji_Column_Num; //一页表情的最多个数
        _pageControl = [UIPageControl new];
        _pageControl.numberOfPages = emojiNum/onePageNum+1;
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    }
    return _pageControl;
}

- (NSArray *)emojiPicArr {
    if (!_emojiPicArr) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        _emojiPicArr = [NSMutableArray arrayWithArray:[dic objectForKey:@"Emoji"]];
    }
    return _emojiPicArr;
}

@end
