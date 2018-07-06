//
//
//  XYCardNormalCell.m
//  XYCardbag
//
//  Created by 渠晓友 on 2018/7/6.
//
//  Copyright © 2018年 xiaoyouPrince. All rights reserved.
//
//  这是正常状态下的卡片Cell

#import "XYCardNormalCell.h"
#import "Masonry.h"

#define k_card_left_right_margin 40     ///< 卡片左右边距 40
#define k_card_top_bottom_margin 10     ///< 卡片上下边距 10
#define k_card_transion_distance 30     ///< 卡片左右移动距离 30
#define k_funcBtn_right_margin 15       ///< 功能键右边距 15
#define k_funcBtn_width_height 40       ///< 功能键宽和高 15

@interface XYCardNormalCell()<CAAnimationDelegate>

@property(nonatomic,weak) UIImageView *cardImageView; ///< 卡片图片
@property(nonatomic,weak) UIView *funcView; ///< 功能View
@property(nonatomic,assign) BOOL showFuncs; ///< 是否展示功能按钮

@end

@implementation XYCardNormalCell
{
    UIImage *whiteImage , *greenImage;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 创建content
        [self setUpContent];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"cardNormalCell";
    
    XYCardNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    // 每次新出来的cell，默认不展示funcView ---> 主要是防止复用
    cell.showFuncs = NO;
    
    return cell;
}

- (void)setUpContent{
    
    whiteImage = [UIImage imageWithColor:UIColor.whiteColor];
    greenImage = [UIImage imageWithColor:UIColor.greenColor];
    self.backgroundColor = [UIColor clearColor];
    
    // 卡片 + 四个功能键 + 左滑手势 + 右滑手势
    UIImageView *cardImageView = [[UIImageView alloc] init];
    cardImageView.layer.cornerRadius = 20;
    cardImageView.clipsToBounds = YES;
    [self.contentView addSubview:cardImageView];
    
    cardImageView.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cardImageSwiped:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [cardImageView addGestureRecognizer:leftSwipe];
    
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cardImageSwiped:)];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [cardImageView addGestureRecognizer:rightSwipe];
    self.cardImageView = cardImageView;
    
    [cardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(k_card_left_right_margin);
        make.top.equalTo(self.contentView).offset(k_card_top_bottom_margin);
        make.right.equalTo(self.contentView).offset(-k_card_left_right_margin);
        make.bottom.equalTo(self.contentView).offset(-k_card_top_bottom_margin);
    }];
    
    cardImageView.image = whiteImage;
    
    // 4 个功能按钮
    UIView *funcView = [UIView new];
    [self.contentView addSubview:funcView];
    self.funcView = funcView;
    funcView.backgroundColor = UIColor.greenColor;
    [funcView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-k_funcBtn_right_margin);
        make.centerY.equalTo(cardImageView);
        make.width.equalTo(@(k_funcBtn_width_height));
        make.height.equalTo(@(k_funcBtn_width_height * 4));
    }];
    
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton new];
        [btn setBackgroundImage:[UIImage imageWithColor:XYRandomColor] forState:UIControlStateNormal];
        btn.tag = i;
        [btn addTarget:self action:@selector(funcBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [funcView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(funcView);
            make.top.equalTo(funcView).offset( i * k_funcBtn_width_height);
            make.width.height.equalTo(@k_funcBtn_width_height);
        }];
    }
    
    
    self.showFuncs = NO;
}


- (void)cardImageSwiped:(UISwipeGestureRecognizer *)swipe
{
    DLog(@"%zd",swipe.direction);
    
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionRight:
        {
            // 右滑是卡片正反图片切换
            if (self.showFuncs) {
                
                // card右滑 + 出现右边的四个功能键
                self.showFuncs = NO;
                
            }else{
                [self layerRotation];
            }
            
        }
            break;
        case UISwipeGestureRecognizerDirectionLeft:
        {
            // 左滑出现对应的卡片切换四个功能按钮
            
            // card左滑 + 出现按钮
            self.showFuncs = YES;
        }
            break;
            
        default:
            break;
    }
}

- (void)setShowFuncs:(BOOL)showFuncs
{
    _showFuncs = showFuncs;
    self.funcView.hidden = !showFuncs;
    
    if (!showFuncs) {
        // 1.卡片做右边移动 30 pt，回到最初状态
        [self.cardImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(k_card_left_right_margin);
            make.right.equalTo(self.contentView).offset(-k_card_left_right_margin);
        }];
    }else{
        // 1.卡片做移动 30 pt，出现funcView
        [self.cardImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(k_card_left_right_margin - k_card_transion_distance);
            make.right.equalTo(self.contentView).offset(-k_card_left_right_margin - k_card_transion_distance);
        }];
    }
}



// 旋转动画。。、、https://www.jianshu.com/p/ed451596a4e1
- (void)layerRotation{
    
    CGFloat actionSeconds = 0.3;
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animation];
    
    // 旋转角度， 其中的value表示图像旋转的最终位置
    
    keyAnimation.values = [NSArray arrayWithObjects:
                           
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
                           
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation((M_PI/2), 0,1,0)],
                           
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0,1,0)],
                           
                           nil];
    
    keyAnimation.cumulative = NO;
    
    keyAnimation.duration = 1.2 * actionSeconds;
    
    keyAnimation.repeatCount = 1;
    
    keyAnimation.removedOnCompletion = NO;
    
    keyAnimation.delegate = self;
    
    [self.cardImageView.layer addAnimation:keyAnimation forKey:@"transform"];
    
    [self performSelector:@selector(changeImg) withObject:nil afterDelay:0.6 * actionSeconds];
    
}


- (void)funcBtnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 0:
        {
            DLog(@"功能1");
        }
            break;
            
        case 1:
        {
            DLog(@"功能2");
        }
            break;
            
        case 2:
        {
            DLog(@"功能3");
        }
            break;
            
        case 3:
        {
            DLog(@"功能4");
        }
            break;
            
        default:
            break;
    }
}

- (void)changeImg{
    if (self.cardImageView.image == whiteImage) {
        self.cardImageView.image = greenImage;
    }else
    {
        self.cardImageView.image = whiteImage;
    }
}


- (void)setModel:(XYBankCardModel *)model
{
    _model = model;
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DLog(@"用户点击当前卡片，进入详情信息");
    
}

@end
