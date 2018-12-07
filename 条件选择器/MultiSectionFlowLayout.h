//
//  MultiSectionFlowLayout.h
//  条件选择器
//
//  Created by 李桂盛 on 2018/12/6.
//  Copyright © 2018 root1. All rights reserved.
////多个分区不同样式

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultiSectionFlowLayout : UICollectionViewFlowLayout


@property (nonatomic, assign ) NSInteger firstSectionCount;

@property (assign,  nonatomic) NSInteger secondSectionCount ;

@property (assign,  nonatomic) NSInteger thirdSectionCount ;

@end

NS_ASSUME_NONNULL_END
