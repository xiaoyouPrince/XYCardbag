//
//
//  XYCardInfoCell.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/9.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//

#import "XYCardInfoCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
@interface XYCardInfoCell ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *frontIcon_btn;
@property (weak, nonatomic) IBOutlet UIButton *rearIcon_btn;

@end

@implementation XYCardInfoCell
{
    BOOL _takeImageForFront;
    BOOL _takeImageForRear;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // default
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // iamge
    self.frontIcon_btn.layer.cornerRadius = 5;
    self.rearIcon_btn.layer.cornerRadius = 5;
    self.frontIcon_btn.clipsToBounds = YES;
    self.rearIcon_btn.clipsToBounds = YES;
    
    
    // addNew
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    NSLog(@"self.reuseIdentifier = %@",self.reuseIdentifier);
    if ([self.reuseIdentifier isEqualToString:@"addNewCell"]) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}




- (void)setModel:(XYCardInfoModel *)model
{
    _model = model;
    
    // 根据每项信息内容的类别区别处理
    switch (model.tagType) {
        case TagTypeBaseImage: /// 处理卡前后图片
        {
            
        }
            break;
        case TagTypeBaseName:
        {
            
        }
            break;
        case TagTypeBaseNumber:
        {
            
        }
            break;
        case TagTypeBaseDesc:
        {
            
        }
            break;
        case TagTypeDate:
        {
            
        }
            break;
        case TagTypePhoneNumber:
        {
            
        }
            break;
        case TagTypeMail:
        {
            
        }
            break;
        case TagTypeNetAddress:
        {
            
        }
            break;
        case TagTypeCustom:
        {
            
        }
            break;
            
        default:
            break;
    }
}


#pragma mark -- actions


/**
 设置卡片的图片
 */
- (IBAction)takeCardImageAction:(UIButton *)sender {
    
    if (sender == self.frontIcon_btn) {
        [sender setImage:[UIImage imageWithColor:UIColor.redColor] forState:UIControlStateNormal];
        _takeImageForFront = YES;
        _takeImageForRear = NO;
    }
    
    if (sender == self.rearIcon_btn) {
        [sender setImage:[UIImage imageWithColor:UIColor.greenColor] forState:UIControlStateNormal];
        _takeImageForFront = NO;
        _takeImageForRear = YES;
    }
    
    // 弹出设置类型的选择框
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc]init];
    imgPicker.delegate = self;
    imgPicker.allowsEditing = YES;
    
    // rootVc 弹出
    UIViewController *rootVc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIAlertAction * xcAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            //            [MyMBProgHUD showInfo:@"请打开相册权限，否则无法选取照片!"];
            [XYAlertView showAlertTitle:@"提示" message:@"请打开相册权限，否则无法选取照片!" Ok:nil];
            
            return;
        }
        
        imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [rootVc presentViewController:imgPicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction * pzAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
        {
            //            [MyMBProgHUD showInfo:@"请打开相机权限，否则无法拍照!"];
            [XYAlertView showAlertTitle:@"提示" message:@"请打开相机权限，否则无法选取照片!" Ok:nil];
            return;
        }
        
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [rootVc presentViewController:imgPicker animated:YES completion:nil];
        
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
    }];
    
    [alert addAction:xcAction];
    [alert addAction:pzAction];
    [alert addAction:cancelAction];
    
    [rootVc presentViewController:alert animated:YES completion:nil];

    
    
    NSLog(@"当前图片 %@",[sender imageForState:UIControlStateNormal]);
    
//    [sender setImage:[UIImage imageWithColor:UIColor.redColor] forState:UIControlStateNormal];
//    [sender setImage:[UIImage imagena:@"love.jpg"] forState:UIControlStateNormal];
    
    NSLog(@"当前图片 %@",[sender imageForState:UIControlStateNormal]);
}

#pragma mark - 图片选择控制器的代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1.销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 2.去的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 3.图片简单处理
    if (_takeImageForFront) {
        [self.frontIcon_btn setImage:image forState:UIControlStateNormal];
    }
    if (_takeImageForRear) {
        [self.rearIcon_btn setImage:image forState:UIControlStateNormal];
    }
    
}


/**
 正反面图片切换
 */
- (IBAction)changeFrontRearImage:(id)sender {
    
    UIImage *frontImage = [self.frontIcon_btn imageForState:UIControlStateNormal];
    UIImage *rearImage = [self.rearIcon_btn imageForState:UIControlStateNormal];
    [self.frontIcon_btn setImage:rearImage forState:UIControlStateNormal];
    [self.rearIcon_btn setImage:frontImage forState:UIControlStateNormal];
}




#pragma mark -- public -- 创建方法

/// 创建传卡片图片的cell
+ (instancetype)cellForCardImagesWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cardImageCell";
    XYCardInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    }
    return cell;
}

/// 创建传卡片名称的cell
+ (instancetype)cellForCardNameWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cardNameCell";
    XYCardInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][1];
    }
    return cell;
}


/// 创建传卡片卡号的cell
+ (instancetype)cellForCardNumberWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cardNumberCell";
    XYCardInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][2];
    }
    return cell;
}

/// 创建传卡片描述的cell
+ (instancetype)cellForCardDescWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"cardDescCell";
    XYCardInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][3];
    }
    return cell;
}
//
///// 创建传卡片自定义信息的cell - [需根据对应的model，根据具体自定义类型创建对应UI]
//+ (instancetype)cellForCardInfoWithTableView:(UITableView *)tableView model:(XYCardInfoModel *)model;

/// 创建添加的更多卡片信息的cell
+ (instancetype)cellForAddNewWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"addNewCell";
    XYCardInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][4];
    }
    return cell;
}




@end
