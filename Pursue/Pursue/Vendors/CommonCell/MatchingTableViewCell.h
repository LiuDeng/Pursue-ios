//
//  MatchingTableViewCell.h
//  Pursue
//
//  Created by 罗嗣宝 on 15/7/6.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchingData.h"

@interface MatchingTableViewCell : UITableViewCell

- (void)setMatchingData:(MatchingData*)matchingData;

- (void)showAnimation;

@end
