//
//  ViewController.m
//  CollectionView
//
//  Created by 1234 on 16/3/10.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "EmojiView.h"
#import "EmojiKeyboardView.h"
static NSString *const EmojiCollectionViewCellR = @"EmojiCollectionViewCellR";
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView *mainCollectionView;
    NSMutableArray *arr;
}
@end

@implementation ViewController

#pragma mark-----life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arr  =[NSMutableArray array];
    
    //读取Plist文件
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    arr = [NSMutableArray arrayWithArray:[dic objectForKey:@"Emoji"]];
    
    [self setupView];
    [self layoutUI];
    
   
    // Do any additional setup after loading the view.
}

- (void)setupView {
    
    [EmojiKeyboardView addEmojiKeyboardViewOnSuperView:self.view];
}

- (void)layoutUI {
    
    
}



#pragma mark-----Private Method

- (void)longGesAction {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [EmojiKeyboardView showEmojiKeyBoardViewWithKeyboardViewState:EmojiKeyboardViewStateB];
}

#pragma mark-----Public  Method

#pragma mark-----Notification Method

@end
