//
//  RecordInfoEditViewController.m
//  Pursue
//
//  Created by 罗嗣宝 on 15/6/24.
//  Copyright (c) 2015年 Luce Studio. All rights reserved.
//

#import "XLForm.h"
#import "Utils.h"
#import "XLFormValidator+Util.h"
#import "RecordInfoEditViewController.h"
#import "UploadPhotoCell.h"

@interface RecordInfoEditViewController ()

@end

@implementation RecordInfoEditViewController

NSString *const recordName = @"name";
NSString *const recordSex = @"sex";
NSString *const recordBirthday = @"birthday";
NSString *const recordDate = @"lostDate";
NSString *const recordLocation = @"location";
NSString *const recordDescription = @"description";

-(id)init
{
    self = [super init];
    if (self) {
        [self initializeForm];
    }
    return self;
}

-(void)initializeForm
{
    XLFormDescriptor * formDescriptor = [XLFormDescriptor formDescriptorWithTitle:@"发布随拍"];
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    formDescriptor.assignFirstResponderOnShow = YES;
    
    // Basic Information - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"基本资料"];
    [formDescriptor addFormSection:section];
    
    // Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:recordName rowType:XLFormRowDescriptorTypeText title:@"姓名"];
    [row.cellConfigAtConfigure setObject:@"请输入所要寻找人姓名" forKey:@"textField.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    // Sex
    row = [XLFormRowDescriptor formRowDescriptorWithTag:recordSex rowType:XLFormRowDescriptorTypeText title:@"性别"];
    [row.cellConfigAtConfigure setObject:@"请输入所要寻找人性别" forKey:@"textField.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    // Birthday
    row = [XLFormRowDescriptor formRowDescriptorWithTag:recordBirthday rowType:XLFormRowDescriptorTypeSelectorAlertView title:@"年龄"];
    row.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"1~5岁"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"6~10岁"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"11~18岁"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"19~25岁"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"26~35岁"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(3) displayText:@"36岁以上"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(4) displayText:@"未知"]
                            ];
    row.value = [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@"未知"];
    [section addFormRow:row];
    
    // LostDate
    row = [XLFormRowDescriptor formRowDescriptorWithTag:recordDate rowType:XLFormRowDescriptorTypeDate title:@"发现时间"];
    //    [row.cellConfigAtConfigure setObject:@"请输入所要寻找人生日" forKey:@"textField.placeholder"];
    row.value = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    row.required = YES;
    
    [section addFormRow:row];
    
    // Location
    row = [XLFormRowDescriptor formRowDescriptorWithTag:recordLocation rowType:XLFormRowDescriptorTypeText title:@"地点"];
    [row.cellConfigAtConfigure setObject:@"请选择事发地点" forKey:@"textField.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    
    // Description - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"特征描述"];
    section.footerTitle = @"请控制在120个字以内";
    [formDescriptor addFormSection:section];
    
    // Description
    row = [XLFormRowDescriptor formRowDescriptorWithTag:recordDescription rowType:XLFormRowDescriptorTypeTextView];
//    [row.cellConfigAtConfigure setObject:@"请输入所要寻找人姓名" forKey:@"textField.placeholder"];
    row.required = YES;
    [section addFormRow:row];
    
    // LostDescription - Section
    section = [XLFormSectionDescriptor formSectionWithTitle:@"详细描述"];
    section.footerTitle = @"请控制在1000个字以内";
    [formDescriptor addFormSection:section];
    
    // LostDescription
    row = [XLFormRowDescriptor formRowDescriptorWithTag:recordDescription rowType:XLFormRowDescriptorTypeTextView];
    row.required = YES;
    [section addFormRow:row];
    
    //走失人照片
    section = [XLFormSectionDescriptor formSectionWithTitle:@"照片"];
    section.footerTitle = @"请上传清晰的照片，以便系统匹配查找";
    [formDescriptor addFormSection:section];
    
    XLFormRowDescriptor *personPhotoRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"personPhoto" rowType:@"XLFormRowDescriptorTypeCustom"];
    personPhotoRow.cellClass = [UploadPhotoCell class];
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    [photos addObject:@"面部1"];
    [photos addObject:@"面部2"];
    [photos addObject:@"全身"];
    [photos addObject:@"其他1"];
    [photos addObject:@"其他2"];
    personPhotoRow.value = photos;
    [section addFormRow:personPhotoRow];
    
    self.form = formDescriptor;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelPressed:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleDone target:self action:@selector(savePressed:)];
}


-(void)cancelPressed:(UIBarButtonItem *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)savePressed:(UIBarButtonItem *)button
{
    
}


#pragma mark -  TableView

/**
 *  设置section标题
 *
 *  @param tableView <#tableView description#>
 *  @param section   section description
 *
 *  @return <#return value description#>
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(16, 20, 320, 16);
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithHex:0x333333];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.text = sectionTitle;
    
    UIView *view = [[UIView alloc] init];
    [view addSubview:label];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // change cell height of a particular cell
    if ([[self.form formRowAtIndex:indexPath].tag isEqualToString:@"personPhoto"]){
        return 80.0;
    }else if ([[self.form formRowAtIndex:indexPath].tag isEqualToString:@"fatherPhoto"]){
        return 80.0;
    }else if ([[self.form formRowAtIndex:indexPath].tag isEqualToString:@"motherPhoto"]){
        return 80.0;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

/**
 *  设置标题头的高度
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

/**
 *  设置标题尾的高度
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 25;
}


@end
