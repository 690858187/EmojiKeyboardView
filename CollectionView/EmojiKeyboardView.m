//
//  EmojiKeyboardView.m
//  CollectionView
//
//  Created by 1234 on 16/3/15.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "EmojiKeyboardView.h"
#import "EmojiView.h"
#import "Masonry.h"
@interface EmojiKeyboardView ()
@property (nonatomic, strong) NSArray *emojiPicArr;
@property (nonatomic, strong) EmojiKeyboardView *keyboardView;
@end

@implementation EmojiKeyboardView

#pragma mark-----life cycle

+(EmojiKeyboardView *)shareEmojiKeyboardView {
    static EmojiKeyboardView *sharekeyboardView = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharekeyboardView = [[self alloc] init];
    });
    return sharekeyboardView;
}

#pragma mark-----Private Method

- (void)addEmojis {
    
    for (int i = 0; i<4; i++) {
        
        for (int j= 0; j<5; j++) {
            
        }
    }
    
}

#pragma mark-----Public  Method

- (void)addEmojiKeyboardViewOnSuperView:(UIView *)view {
    
    self.keyboardView = [EmojiKeyboardView shareEmojiKeyboardView];
    [self.keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.equalTo(@216);
    }];
    [view addSubview:self.keyboardView];
}


#pragma mark-----Notification Method

- (NSArray *)emojiPicArr {
    if (!_emojiPicArr) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        _emojiPicArr = [NSMutableArray arrayWithArray:[dic objectForKey:@"Emoji"]];
    }
    return _emojiPicArr;
}

@end
