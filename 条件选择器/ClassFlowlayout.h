//
//  ClassFlowlayout.h
//  条件选择器
//
//  Created by root1 on 2018/12/6.
//  Copyright © 2018 root1. All rights reserved.

///分类Flowlayout () ///默认4列
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClassFlowlayout : UICollectionViewFlowLayout

//传递的个数
@property (nonatomic, assign) NSInteger itemCount;

@end

NS_ASSUME_NONNULL_END
