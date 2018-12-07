# UICollectionViewFlowLayout-
自定义UICollectionViewFlowLayout处理条件筛选


##背景
#项目中使用了一些条件选择筛选（暂且叫做条件选择器），来做筛选操作。如图：
![6C212B74CB3AB48B88AA672417EAB641.png](https://upload-images.jianshu.io/upload_images/3015045-953b2656f2361ed0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![E4AF3124145BEFABD7454417CE7F99EB.png](https://upload-images.jianshu.io/upload_images/3015045-7820f4d6f55292e3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![E93F16CB594A30773B4F7B3AFF7394EC.png](https://upload-images.jianshu.io/upload_images/3015045-9ef46309d48d2df7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

大概的样子是这样的。

自己在思考如果去实现这一个需求要怎么去做呢？（看我的昵称 我也很慌啊 怎么办 只能硬上了）

我想到了使用自定义UICollectionViewFlowLayout，通过三个不同的UICollectionViewFlowLayout，来控制同一个UICollectionView，来实现内容的转换。
代码如下：
.h文件：
```
///分类Flowlayout () ///默认4列
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassFlowlayout : UICollectionViewFlowLayout

//传递的个数
@property (nonatomic, assign) NSInteger itemCount;

@end

NS_ASSUME_NONNULL_END
```

```

#import "ClassFlowlayout.h"

#define itemMargin 20
#define itemHeight 40

#define SCREEN_W  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H  ([UIScreen mainScreen].bounds.size.height)

**.m文件 
自定义一个FlowLayout布局类就是两个步骤：
1、设计好我们的布局配置数据 prepareLayout方法中
2、返回我们的配置数组 layoutAttributesForElementsInRect方法中**

@interface ClassFlowlayout()
{
NSMutableArray *attributeArray;
}
@end


@implementation ClassFlowlayout


-(void)prepareLayout
{
    attributeArray = [[NSMutableArray alloc]init];
    
    [super prepareLayout];
    
    //找到每一个item的frame 暂定一排最多显示4个
    CGFloat btnW = (SCREEN_W - self.sectionInset.left - self.sectionInset.right-self.minimumInteritemSpacing*3) / 4;
    
    CGFloat cellHeight[4] = {self.sectionInset.top,self.sectionInset.top+0.001,self.sectionInset.top+0.0011,self.sectionInset.top+0.0012};
    
    
    for(int i = 0;i < _itemCount ; i++) {
        
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
        
        int heightestIndex = 0;
        
        ////找到高度最低的哪一列 t添加cell
        if (cellHeight[0] < cellHeight[1] && cellHeight[0] < cellHeight[2] && cellHeight[0] < cellHeight[3] ) {
            
            cellHeight[0] = cellHeight[0] + itemHeight + self.minimumLineSpacing;
            
            heightestIndex = 0;
            
        }
        else if (cellHeight[1] < cellHeight[0] && cellHeight[1] < cellHeight[2] && cellHeight[1] < cellHeight[3] ) {
            
            cellHeight[1] = cellHeight[1] + itemHeight + self.minimumLineSpacing;
            
            heightestIndex = 1;
        }
        
       else if (cellHeight[2] < cellHeight[0] && cellHeight[2] < cellHeight[1] && cellHeight[2] < cellHeight[3] ) {
            
            cellHeight[2] = cellHeight[2] + itemHeight + self.minimumLineSpacing;
            
            heightestIndex = 2;
        }
        
      else  if (cellHeight[3] < cellHeight[0] && cellHeight[3] < cellHeight[1] && cellHeight[3] < cellHeight[2] ) {
            
            cellHeight[3] = cellHeight[3] + itemHeight + self.minimumLineSpacing;
            
            heightestIndex = 3;
        }
        
        attris.frame = CGRectMake(self.sectionInset.left + (btnW + self.minimumInteritemSpacing)*heightestIndex, cellHeight[heightestIndex] - itemHeight-self.minimumLineSpacing, btnW, itemHeight);
        
       
        
        [attributeArray addObject:attris];
    }
    
    
        ////设置itemSize
        if (cellHeight[0] > cellHeight[1] && cellHeight[0] > cellHeight[2] && cellHeight[0] > cellHeight[3] ) {
            
///计算itemsize  这个公式简化过
            self.itemSize = CGSizeMake(btnW, (cellHeight[0]-self.sectionInset.top)*4/_itemCount - 3*self.minimumLineSpacing);
            
        }
        
        if (cellHeight[1] > cellHeight[0] && cellHeight[1] > cellHeight[2] && cellHeight[1] > cellHeight[3] ) {
            
            self.itemSize = CGSizeMake(btnW, (cellHeight[1]-self.sectionInset.top)*4/_itemCount - 3*self.minimumLineSpacing);
            
        }
        
        if (cellHeight[2] > cellHeight[0] && cellHeight[2] > cellHeight[1] && cellHeight[2] > cellHeight[3] ) {
            
            self.itemSize = CGSizeMake(btnW, (cellHeight[2]-self.sectionInset.top)*4/_itemCount - 3*self.minimumLineSpacing);
            
        }
        
        if (cellHeight[3] > cellHeight[0] && cellHeight[3] > cellHeight[1] && cellHeight[3] > cellHeight[2] ) {
            
            self.itemSize = CGSizeMake(btnW, (cellHeight[3]-self.sectionInset.top)*4/_itemCount - 3*self.minimumLineSpacing);
            
        }
        
    
    
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return attributeArray;
}

@end
```
##第二个样式的cell
```
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleFlowLayout : UICollectionViewFlowLayout

@property(nonatomic,assign) NSInteger itemCount;


@end

NS_ASSUME_NONNULL_END
```


.m文件
```
#import "SingleFlowLayout.h"
#define itemHeight 60

#define itemMargin 20
#define SCREEN_W  ([UIScreen mainScreen].bounds.size.width)

@interface SingleFlowLayout()
{
    NSMutableArray *attributeArray;
}
@end

@implementation SingleFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    attributeArray = [[NSMutableArray alloc]init];
    CGFloat heightArray[1] = {self.sectionInset.top};
    
    for (int i = 0; i < self.itemCount ; i++) {
        
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        
        UICollectionViewLayoutAttributes *attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
        
        heightArray[0] = heightArray[0] + itemHeight + self.minimumLineSpacing;
        
        attris.frame = CGRectMake(self.sectionInset.left, heightArray[0]-itemHeight-self.minimumLineSpacing, SCREEN_W, itemHeight);
        [attributeArray addObject:attris];
        
    }
    
    self.itemSize = CGSizeMake(SCREEN_W, itemHeight);
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    return attributeArray;
}
@end
```

##第三个
.h
```
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultiSectionFlowLayout : UICollectionViewFlowLayout


@property (nonatomic, assign ) NSInteger firstSectionCount;

@property (assign,  nonatomic) NSInteger secondSectionCount ;

@property (assign,  nonatomic) NSInteger thirdSectionCount ;

@end

NS_ASSUME_NONNULL_END
```
.m
```
#import "MultiSectionFlowLayout.h"
#define itemHeight 60
#define firstItemWidth   200
#define secondItemWidth  100
#define thirdItemWidth   130
@interface MultiSectionFlowLayout()
{
    NSMutableArray *attributeArray;
}
@end

@implementation MultiSectionFlowLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    attributeArray = [[NSMutableArray alloc]init];
    
    CGFloat heightArray[1] = {self.sectionInset.top};
    
    for (int i = 0;i < _firstSectionCount; i++) {
        
        NSIndexPath *index = [NSIndexPath indexPathWithIndex:i];
        
        UICollectionViewLayoutAttributes *attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
        
        heightArray[0] = heightArray[0] + self.minimumLineSpacing + itemHeight;
        
        attris.frame = CGRectMake(self.sectionInset.left, heightArray[0]-itemHeight-self.minimumLineSpacing, firstItemWidth, itemHeight);
        
         NSLog(@"%@",NSStringFromCGRect(attris.frame));
        
        [attributeArray addObject:attris];
    }
    
    for (int i = 0; i < _secondSectionCount; i++) {
        
        NSIndexPath *index = [NSIndexPath indexPathWithIndex:i];
        
        UICollectionViewLayoutAttributes *atttis = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
        heightArray[0] = heightArray[0] + self.minimumLineSpacing + itemHeight;
        
        atttis.frame = CGRectMake(self.sectionInset.left, heightArray[0] - itemHeight - self.minimumLineSpacing, secondItemWidth, itemHeight);
        
         NSLog(@"%@",NSStringFromCGRect(atttis.frame));
        
        [attributeArray addObject:atttis];
    }
    
    for (int i = 0; i < _thirdSectionCount; i++) {
        
        NSIndexPath *index = [NSIndexPath indexPathWithIndex:i];
        
        UICollectionViewLayoutAttributes *atttis = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
        heightArray[0] = heightArray[0] + self.minimumLineSpacing + itemHeight;
        
        atttis.frame = CGRectMake(self.sectionInset.left, heightArray[0] - itemHeight - self.minimumLineSpacing, thirdItemWidth, itemHeight);
        
        NSLog(@"%@",NSStringFromCGRect(atttis.frame));
        
        [attributeArray addObject:atttis];
    }
///这一块有一个疑问：
   ##对于 itemSize在这样样式的layout中如何获取,求解答。   
}
@end
```


##最后在VC中使用它们

```
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
```

##最后demo的效果：
![未命名.gif](https://upload-images.jianshu.io/upload_images/3015045-056a658e76a46a45.gif?imageMogr2/auto-orient/strip)
