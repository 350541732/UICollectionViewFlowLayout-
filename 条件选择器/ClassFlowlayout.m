//
//  ClassFlowlayout.m
//  条件选择器
//
//  Created by root1 on 2018/12/6.
//  Copyright © 2018 root1. All rights reserved.
//


#import "ClassFlowlayout.h"

#define itemMargin 20
#define itemHeight 40

#define SCREEN_W  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H  ([UIScreen mainScreen].bounds.size.height)

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
        
        ////
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
