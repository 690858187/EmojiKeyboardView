//
//  EmojiView.h
//  CollectionView
//
//  Created by 1234 on 16/3/15.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmojiView : UIView
@property (nonatomic, strong) UIImage *emojiImage;
@property (nonatomic, copy) void (^eBlock)();
@end
