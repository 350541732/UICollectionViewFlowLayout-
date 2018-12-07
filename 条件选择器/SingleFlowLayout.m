//
//  SingleFlowLayout.m
//  条件选择器
//
//  Created by root1 on 2018/12/6.
//  Copyright © 2018 root1. All rights reserved.
//

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
