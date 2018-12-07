//
//  ViewController.m
//  条件选择器
//
//  Created by root1 on 2018/12/6.
//  Copyright © 2018 root1. All rights reserved.
//

#import "ViewController.h"
#import "ClassFlowlayout.h"
#import "SingleFlowLayout.h"
#import "MultiSectionFlowLayout.h"

#define SCREEN_W  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H  ([UIScreen mainScreen].bounds.size.height)
@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property(nonatomic,strong)ClassFlowlayout *classFlowLayout;

@property(nonatomic,strong)SingleFlowLayout *singleFlowLayout;

@property (nonatomic, strong) MultiSectionFlowLayout *multiFlowLayout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.classFlowLayout.itemCount = 7;
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 80, 100, 50);
    [btn1 setTitle:@"流水布局" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(classBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(200, 80, 100, 50);
    [btn2 setTitle:@"单行布局" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(singleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(300, 80, 100, 50);
    [btn3 setTitle:@"多行布局" forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(multiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 150,SCREEN_W , SCREEN_H-300) collectionViewLayout:self.classFlowLayout];
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"1"];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.view addSubview:self.collectionView];
   
    
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 7;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"1" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255 / 255.0 green:arc4random()%255 / 255.0 blue:arc4random()%255 / 255.0 alpha:1];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
}



-(void)classBtnClick:(UIButton *)sender
{
    self.classFlowLayout.itemCount = 7;
    [self.collectionView setCollectionViewLayout:self.classFlowLayout animated:YES];
    
    [self.collectionView reloadData];
}

-(void)singleBtnClick:(UIButton *)sender
{
    self.singleFlowLayout.itemCount = 7;
    [self.collectionView setCollectionViewLayout:self.singleFlowLayout animated:YES];
    
    [self.collectionView reloadData];
}

-(void)multiBtnClick:(UIButton *)sender {
    
    self.multiFlowLayout.firstSectionCount = 3;
    self.multiFlowLayout.secondSectionCount = 2;
    self.multiFlowLayout.thirdSectionCount = 2;
    
    [self.collectionView setCollectionViewLayout:self.multiFlowLayout animated:YES];
    
    [self.collectionView reloadData];
}
#pragma marks --lazy load

-(ClassFlowlayout *)classFlowLayout
{
    if (!_classFlowLayout) {
        _classFlowLayout = [[ClassFlowlayout alloc] init];
    }
    return _classFlowLayout;
}

-(SingleFlowLayout *)singleFlowLayout
{
    if (!_singleFlowLayout) {
        _singleFlowLayout = [[SingleFlowLayout alloc]init];
    }
    return _singleFlowLayout;
}
-(MultiSectionFlowLayout *)multiFlowLayout
{
    if (!_multiFlowLayout) {
        _multiFlowLayout = [[MultiSectionFlowLayout alloc]init];
    }
    return _multiFlowLayout;
}
#pragma marks --- Flowlayout Delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger i = indexPath.row;
    
    if(collectionViewLayout == self.multiFlowLayout) {
        
        if (i>=0 && i<self.multiFlowLayout.firstSectionCount) {
            return  CGSizeMake(SCREEN_W - 30, 60);
            
        }
        if (i >= self.multiFlowLayout.firstSectionCount && i<(self.multiFlowLayout.firstSectionCount+self.multiFlowLayout.secondSectionCount)) {
            return CGSizeMake((SCREEN_W-100)/2, 60);
        }
        if (i>=(self.multiFlowLayout.firstSectionCount+self.multiFlowLayout.secondSectionCount) && i<(self.multiFlowLayout.firstSectionCount + self.multiFlowLayout.secondSectionCount + self.multiFlowLayout.thirdSectionCount)) {
            return CGSizeMake(150, 60);
        }
    }
    return CGSizeZero;
}
@end
