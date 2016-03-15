//
//  ViewController.m
//  CollectionView
//
//  Created by 1234 on 16/3/10.
//  Copyright © 2016年 XDBB. All rights reserved.
//

#import "ViewController.h"
#import "EmojiCollectionViewCell.h"
#import "Masonry.h"
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
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(44, 39);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    mainCollectionView.backgroundColor = [UIColor whiteColor];
    mainCollectionView.pagingEnabled = YES;
    mainCollectionView.dataSource = self;
    mainCollectionView.delegate = self;
    // mainCollectionView.allowsSelection = YES;
    [mainCollectionView registerClass:[EmojiCollectionViewCell class] forCellWithReuseIdentifier:EmojiCollectionViewCellR];
    [self.view addSubview:mainCollectionView];
    
    //    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesAction)];
    //    [mainCollectionView addGestureRecognizer:longGes];
}

- (void)layoutUI {
    
    [mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@216);
    }];
    
}

#pragma mark-----UICollectionViewDataSource,UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EmojiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:EmojiCollectionViewCellR forIndexPath:indexPath];
    //cell.contentView.backgroundColor = [UIColor colorWithRed:121/255.0 green:169/255.0 blue:226/255.0 alpha:1];
    cell.image = [UIImage imageNamed:arr[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return arr.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    [arr replaceObjectAtIndex:sourceIndexPath.row withObject:arr[destinationIndexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

   
}


#pragma mark-----Private Method

- (void)longGesAction {
    
}

#pragma mark-----Public  Method

#pragma mark-----Notification Method

@end
