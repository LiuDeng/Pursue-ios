//
//  UploadPhotoCell.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/7/12.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "UploadPhotoCell.h"
#import "PhotoSelectView.h"
#import <Masonry.h>

@implementation UploadPhotoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void) initView {
}

- (void)configure
{
    [super configure];
}

- (void)update
{
    [super update];
    
    for(UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    
    double screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 80)];
    [self addSubview:scrollView];
    
    scrollView.contentSize = CGSizeMake(400, 80);
    scrollView.showsHorizontalScrollIndicator = NO;
    _photos = self.rowDescriptor.value;
    for (int i = 0; i < [_photos count]; i++) {
        PhotoSelectView *psv = [[PhotoSelectView alloc] initWithTipInfo: _photos[i]];
        psv.frame = CGRectMake(i * 80, 0, 80, 80);
        [scrollView addSubview:psv];
    }
}

-(void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller
{
//    self.rowDescriptor.value = self.textLabel.text;
    [self.formViewController.tableView selectRowAtIndexPath:nil animated:YES scrollPosition:UITableViewScrollPositionNone];
}

@end
