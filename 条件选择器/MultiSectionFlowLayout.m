//
//  MultiSectionFlowLayout.m
//  条件选择器
//
//  Created by 李桂盛 on 2018/12/6.
//  Copyright © 2018 root1. All rights reserved.
//

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

//    for (int i = 0;i< (_firstSectionCount + _secondSectionCount + _thirdSectionCount); i ++) {
////        NSIndexPath *index = [NSIndexPath indexPathWithIndex:i];
//
//        if (i>=0 && i<_firstSectionCount) {
//             self.itemSize = CGSizeMake(firstItemWidth, itemHeight);
//
//        }
//        if (i >= _firstSectionCount && i<(_firstSectionCount+_secondSectionCount)) {
//            self.itemSize = CGSizeMake(secondItemWidth, itemHeight);
//        }
//        if (i>=(_firstSectionCount+_secondSectionCount) && i<(_firstSectionCount + _secondSectionCount + _thirdSectionCount)) {
//            self.itemSize = CGSizeMake(thirdItemWidth, itemHeight);
//        }
//    }
   
    
}
@end
