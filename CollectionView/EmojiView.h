//
//  EmojiKeyboardView.h
//  CollectionView
//
//  Created by 1234 on 16/3/15.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmojiView : UIScrollView
@property (nonatomic, copy) void (^EmojiBlock)(NSInteger currentPage);
@property (nonatomic, copy) void (^touchEmojiBlock)(UIImage * currentEmojiImage);
@end
