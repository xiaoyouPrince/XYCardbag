//
//  XYAlbumContentViewController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import "XYAlbumContentViewController.h"
#import "ImageCollectionViewCell.h"
#import "XYAlbumTool.h"
#import "XYEditViewController.h"

@interface XYAlbumContentViewController ()<XYEidtViewControllerDelegate>
/// 获取到的photo数组
@property (nonatomic, strong) PHFetchResult *fetchResult;
/** isLoaded 标记是否已经加载完成图片数据 */
@property (nonatomic, assign)         BOOL isLoaded;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/** layout */
@property (nonatomic, strong)       UICollectionViewFlowLayout * layout;

@end

@implementation XYAlbumContentViewController

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}

- (void)setAssetCollection:(PHAssetCollection *)assetCollection
{
    _assetCollection = assetCollection;
    [self initData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self setupNav];
}

- (void)initData{
    
    // 基本数据
    if (self.assetCollection) {
        self.fetchResult = self.assetCollection.assets;
        self.isLoaded = YES;
        [self.collectionView reloadData];
    }else
    {
        // 重新获取
        [SVProgressHUD show];
        [XYAlbumTool fetchAlbumsCollectionBack:^(NSArray * _Nonnull collection) {
            
            [SVProgressHUD dismiss];
            self.fetchResult = ((PHAssetCollection *)collection.firstObject).assets;
            self.isLoaded = YES;
            [self.collectionView reloadData];
        }];
    }
    
}

- (void)setupNav
{
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else{
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    
    self.title = self.assetCollection == nil?@"所有照片":self.assetCollection.localizedTitle;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.collectionView.collectionViewLayout = self.layout;
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (ScreenW - 4 - 6) / 4;
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2; // 暂定2pt边距
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.fetchResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    PHAsset *phAsset = [self.fetchResult objectAtIndex:indexPath.row];
    cell.photoData = phAsset;
    //cell.delegate = self;
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PHAsset *phAsset = [self.fetchResult objectAtIndex:indexPath.row];
    
    // 值可以选择p图片
    if (phAsset.mediaType != PHAssetMediaTypeImage) {
        return;
    }
    
    // 图片进入编辑页面
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    options.networkAccessAllowed = YES;
    [SVProgressHUD show];
    [[PHImageManager defaultManager] requestImageDataForAsset:phAsset options:options resultHandler:^(NSData * _Nullable imageData, NSString * dataUTI, UIImageOrientation orientation, NSDictionary * info) {
        [SVProgressHUD dismiss];
        UIImage *image = [UIImage imageWithData:imageData];
        XYEditViewController *vc = [[XYEditViewController alloc] initWithNibName:@"XYEditViewController" bundle:nil];
        vc.delegate = self;
        vc.image = image;
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


#pragma mark -XYEidtViewControllerDelegate

- (void)imageEidtFinish:(UIImage *)image
{
    // 编辑完成 -- 图片发送给
    [kNotificationCenter postNotificationName:@"imageEidtFinish" object:image];
    
}

@end
