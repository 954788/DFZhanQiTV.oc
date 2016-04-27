//
//  TvCollectionViewCell.h
//  DFZhanQiTv.oc
//
//  Created by 梁粱展焯 on 16/4/21.
//  Copyright © 2016年 粱展焯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TvCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, copy) NSString *urlString;

@end
