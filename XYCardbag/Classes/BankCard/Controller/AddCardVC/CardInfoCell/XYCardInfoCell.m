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
#import "Masonry.h"

@protocol XYTextViewDelegate <UITextViewDelegate>
// 这里直接使用父类协议的协议方法
@end
@interface XYTextView : UITextView
@property(nonatomic,weak) id<XYTextViewDelegate> xy_delegate;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;
@end
@interface XYTextView ()<UITextViewDelegate>
@property (nonatomic,strong) UILabel *placeholderLabel;
@end

@implementation XYTextView

#warning TODO -- 研究一下为什么这里不用懒加载不行？?

- (UILabel *)placeholderLabel
{
    if (_placeholderLabel == nil) {
        _placeholderLabel = [UILabel new];
        
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_placeholderLabel];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.numberOfLines = 0;
        [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(5);
            make.top.equalTo(self).offset(7);
            make.right.bottom.equalTo(self).offset(-10);
        }];
    }
    return _placeholderLabel;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupContent];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setupContent];
    }
    return self;
}

- (void)setupContent{
    // 1. 创建placeholderLabel
    self.delegate = self;
}


- (void)textViewDidChange:(UITextView *)textView{
    DLog(@"TV.text = %@",self.text);
    if(![self.text isEqualToString:@""])
    {
        self.placeholderLabel.hidden = YES;
    }else
    {
        self.placeholderLabel.hidden = NO;
    }
    
    if (self.xy_delegate && [self.xy_delegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.xy_delegate textViewDidEndEditing:self];
    }
}

- (void)setPlaceholder:(NSString *)placeholder
{
    self.placeholderLabel.text = placeholder;
    DLog(@"self.placeholderLabel = %@",self.placeholderLabel);
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    self.placeholderLabel.textColor = placeholderColor;
}

@end


@interface XYCardInfoCell ()< XYTextViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *frontIcon_btn;
@property (weak, nonatomic) IBOutlet UIButton *rearIcon_btn;
@property (strong, nonatomic) IBOutlet UITextField *cardNameTF;
@property (weak, nonatomic) IBOutlet UITextField *cardNumberTF;
@property (weak, nonatomic) IBOutlet XYTextView *cardDescTV;

@end

@implementation XYCardInfoCell
{
    // 判断给正面还是背面设置图片
    BOOL _takeImageForFront;
    BOOL _takeImageForRear;
    
    // 记录卡名称的TF。因为上面的属性只是针对某一个cell的，但是页面创建出来会有好多cell,上面的属性在创建之后用一次，就会再创建新的cell的过程中废掉了，因为在新的cell中没有对应的属性。这里用成员变量也是同样的问题
    // 名称TF,用两个__ 和属性生成的成员变量进行区分一下。。。
    UITextField *__carNameTF;
}

// 使用全局变量也是同样的问题。因为每次awakeFromNib之后都会给全局变量赋值，其保存的值也不稳定
static UITextField *cardTFName;
- (void)awakeFromNib {
    [super awakeFromNib];
    
    // default
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // iamge
    self.frontIcon_btn.layer.cornerRadius = 5;
    self.rearIcon_btn.layer.cornerRadius = 5;
    self.frontIcon_btn.clipsToBounds = YES;
    self.rearIcon_btn.clipsToBounds = YES;
    
    
#warning TODO 用通知的方法肯定不行了，每个通知注册的名称都一样，只是每次传的object不同，导致最后传的object肯定有问题
    
    // name
//    [kNotificationCenter addObserver:self selector:@selector(getNotification:) name:UITextFieldTextDidChangeNotification object:self.cardNameTF];
    
    
    // desc
    self.cardDescTV.xy_delegate = self;
    self.cardDescTV.placeholder = @"卡片备注及其他信息..";
    
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

#pragma mark --  Notification

//- (void)getNotification:(NSNotification *)noti{
//
//    if (noti.object == self.cardNameTF) {
//        NSLog(@"71行中 self.cardNameTF = %@",self.cardNameTF);
//
//    }else{
//
//    }
//
//}



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

    
    
//    NSLog(@"当前图片 %@",[sender imageForState:UIControlStateNormal]);
//    [sender setImage:[UIImage imageWithColor:UIColor.redColor] forState:UIControlStateNormal];
//    [sender setImage:[UIImage imagena:@"love.jpg"] forState:UIControlStateNormal];
//    NSLog(@"当前图片 %@",[sender imageForState:UIControlStateNormal]);
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
//        self.model.frontIconData = UIImagePNGRepresentation(image);
        self.model.frontIconImage = [self scaleAndConfigImage:image];
    }
    if (_takeImageForRear) {
        [self.rearIcon_btn setImage:image forState:UIControlStateNormal];
//        self.model.rearIconData = UIImagePNGRepresentation(image);
        self.model.rearIconImage = [self scaleAndConfigImage:image];
    }
    
}



// 处理一下直接拿到的相册图片，否则太大
- (UIImage *)scaleAndConfigImage:(UIImage *)image{
    
    // 看一下image大小
    DLog(@"image size = %@",NSStringFromCGSize(image.size));
    
    NSInteger psize = image.size.width * image.size.height * image.scale * image.scale;
    DLog(@"image 像素大小 = %ld",(long)psize);
    
    // ----- 重画iamge并返回
    
#warning TODO -- 这里是根据卡片cell内部的边距来定的，日后可能会改。先立个flag
    CGSize newSize = CGSizeMake(ScreenW - 40, 200);
    
    //首先根据image的size的长宽比和newSize进行设置新图片的大小（为了达到等比例缩放不变形的目的）
    CGFloat wTmp;
    CGFloat hTmp;
    CGSize imgSize = image.size;
    if (imgSize.width > imgSize.height) {
        wTmp=newSize.width;
        hTmp = imgSize.height * wTmp / imgSize.width;
    } else {
        hTmp=newSize.height;
        wTmp = imgSize.width * hTmp / imgSize.height;
    }
    
    // Create a graphics image context
    UIGraphicsBeginImageContext(CGSizeMake(wTmp, hTmp));
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,wTmp,hTmp)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    NSInteger nPsize = image.size.width * image.size.height * image.scale * image.scale;
    DLog(@"新图片的像素大小 = %ld",(long)nPsize);
    
    // Return the new image.
    return newImage;
    
}



/**
 正反面图片切换
 */
- (IBAction)changeFrontRearImage:(id)sender {
    
    // UI前后图片切换，model中也要前后图片进行切换
    UIImage *frontImage = [self.frontIcon_btn imageForState:UIControlStateNormal];
    UIImage *rearImage = [self.rearIcon_btn imageForState:UIControlStateNormal];
    [self.frontIcon_btn setImage:rearImage forState:UIControlStateNormal];
    [self.rearIcon_btn setImage:frontImage forState:UIControlStateNormal];
    
    // model 中切换
//    NSData *frontIconData = UIImagePNGRepresentation(frontImage);
//    NSData *rearIconData = UIImagePNGRepresentation(rearImage);
    
//    NSData *temp = self.model.frontIconData;
//    self.model.frontIconData = self.model.rearIconData;
//    self.model.rearIconData = temp;
    
    UIImage *image = self.model.frontIconImage;
    self.model.frontIconImage = self.model.rearIconImage;
    self.model.rearIconImage = image;
}


// ----------------------NAME-------------------

- (IBAction)nameTFhasEndEditing:(UITextField *)sender {
    self.model.title = @"名称";
    self.model.detail = sender.text;
}

// ----------------------CardNumber-------------------
- (IBAction)cardNumberTFhasEndEdting:(UITextField *)sender {
    self.model.title = @"卡号";
    self.model.detail = sender.text;
}


// ----------------------CardDesc TVDelegate-------------------
- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.model.title = @"备注";
    self.model.detail = textView.text;
}

// ----------------------Tags 这里需要单独使用-------------------


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
