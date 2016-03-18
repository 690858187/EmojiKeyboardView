//
//  EmojiKeyboardView.m
//  CollectionView
//
//  Created by 1234 on 16/3/15.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "EmojiView.h"
#import "EmojiKeyboardInputView.h"
#import "Masonry.h"
#define emojiButton_Tag  10000
#define Emoji_Line_Num   7                                              //一行的数量
#define Emoji_Column_Num 4                                              //一列的数量
#define Emoji_Spacing   10                                              //表情间的间距以及距离左右的距离
#define EmojiKeyboardView_Width [UIScreen mainScreen].bounds.size.width //键盘的宽度
#define EmojiKeyboardView_Height 216+26                                 //键盘的高度
#define EmojiPageControl_Height  20                                     //pageControl的高度
#define EmojiEmojiKeyboardView_Height   EmojiKeyboardView_Height - EmojiPageControl_Height                                              //表情高度
#define Emoji_Width  (EmojiKeyboardView_Width-(Emoji_Line_Num +1)*Emoji_Spacing)/Emoji_Line_Num //
#define Emoji_Height (EmojiEmojiKeyboardView_Height-(Emoji_Column_Num +1)*Emoji_Spacing)/Emoji_Column_Num
@interface EmojiView ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *emojiPicArr;
@end

@implementation EmojiView

#pragma mark-----life cycle

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self addEmojis];
        self.delegate = self;
    }
    return self;
}

#pragma mark-----Private Method

/**
 *  加入表情
 */

- (void)addEmojis {
    
    NSInteger emojiNum = self.emojiPicArr.count;    //表情数量
    NSInteger onePageNum = Emoji_Line_Num*Emoji_Column_Num; //一页表情的最多个数
    //确定滑动范围
    self.contentSize = CGSizeMake((emojiNum/onePageNum+1)*[UIScreen mainScreen].bounds.size.width, EmojiKeyboardView_Height);
    for (int i=0; i<emojiNum; i++) {
        
        UIButton *emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [emojiButton setImage:[UIImage imageNamed:self.emojiPicArr[i]] forState:UIControlStateNormal];
        emojiButton.clipsToBounds = YES;
        emojiButton.userInteractionEnabled = YES;
        emojiButton.tag = emojiButton_Tag+i;
        [emojiButton addTarget:self action:@selector(emojiButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:emojiButton];
        emojiButton.frame = CGRectMake((i%Emoji_Line_Num)*(Emoji_Width+Emoji_Spacing)+Emoji_Spacing+i/onePageNum*EmojiKeyboardView_Width, ((i-i/onePageNum*onePageNum)/Emoji_Line_Num)*(Emoji_Height+Emoji_Spacing)+Emoji_Spacing, Emoji_Width, Emoji_Height);
        /**
         *  x:  i%Emoji_Line_Num                        //Emoji_Line_Num个之后换行
         *      Emoji_Width+Emoji_Spacing               //每个表情左右的距离
         *      Emoji_Spacing                           //离左右边框的距离
         *      i/onePageNum*EmojiKeyboardView_Width    //多少个表情之后换页
         *  y:  (i-i/onePageNum*onePageNum)             //多少个表情之后高度重置：即表情高度从第一个开始
         *      (Emoji_Height+Emoji_Spacing)            //每个表情上下的距离
         *      Emoji_Spacing                           //离上边框的距离
         *  w:  Emoji_Width                             //表情宽度
         *  h:  Emoji_Height                            //表情高度
         */
    }
    
}

- (void)emojiButtonAction:(UIButton *)sender {
    
    if (self.touchEmojiBlock) {
        self.touchEmojiBlock([UIImage imageNamed:self.emojiPicArr[sender.tag-emojiButton_Tag]]);
    }
    
}

#pragma mark-----Public  Method

#pragma mark-----UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentPage = scrollView.contentOffset.x/EmojiKeyboardView_Width;
    if (self.EmojiBlock) {
        self.EmojiBlock(currentPage);
    }
}

#pragma mark-----Notification Method

#pragma mark-----getting&&setting

- (NSArray *)emojiPicArr {
    if (!_emojiPicArr) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        _emojiPicArr = [NSMutableArray arrayWithArray:[dic objectForKey:@"Emoji"]];
    }
    return _emojiPicArr;
}
@end
