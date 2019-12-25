//
//  XYAlbumGroupViewController.m
//  XYCardbag
//
//  Created by 渠晓友 on 2019/12/25.
//  Copyright © 2019 xiaoyou. All rights reserved.
//

#import "XYAlbumGroupViewController.h"
#import "XYAlbumContentViewController.h"
#import <Photos/Photos.h>
#import "XYAlbumTool.h"
#import "AlbumGroupTableViewCell.h"

@interface XYAlbumGroupViewController ()<UITableViewDataSource, UITableViewDelegate,PHPhotoLibraryChangeObserver,XYAlbumContentControllerDelegate>
@property (nonatomic, weak) XYAlbumContentViewController *albumContentController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *groupList; /// 所有的列表(里面包含空列表)
@property (nonatomic, strong) NSArray *contentGroupList; /// 包含数据的列表
@property (nonatomic, assign) NSTimeInterval lastChangeTimeInterval;

@end

@implementation XYAlbumGroupViewController

- (void)dealloc{
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self configerView];
    [self addNotification];
    [self openShowPicList];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.groupList == nil) {
        [self getAssetCollections];
    }
}

- (void)addNotification{
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

- (void)configerView{
    self.title = @"照片";
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }else{
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    [self.tableView registerNib:[UINib nibWithNibName:@"AlbumGroupTableViewCell" bundle:nil] forCellReuseIdentifier:@"AlbumGroupTableViewCell"];
    
}


- (void)getAssetCollections{
    
    if (self.groupList == nil) {
        [SVProgressHUD show];
    }
    [XYAlbumTool fetchAlbumsCollectionBack:^(NSArray * _Nonnull collection) {
        [SVProgressHUD dismiss];
        
        // 过滤里面只有一个的情况
        NSMutableArray *arrayM = @[].mutableCopy;
        for (PHAssetCollection *col in collection) {
            if (col.assets.count) {
                [arrayM addObject:col];
            }
        }
        self.contentGroupList = arrayM.copy;
        self.groupList = collection;
        [self changedAlbumContentController];
        [self.tableView reloadData];
    }];
    
}

- (void)openShowPicList{
    
    PHAssetCollection *assetCollection = [self.groupList firstObject];
    XYAlbumContentViewController *vc = [[XYAlbumContentViewController alloc] initWithNibName:@"XYAlbumContentViewController" bundle:nil];
    vc.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    vc.delegate = self;
    vc.assetCollection = assetCollection;
    [self.navigationController pushViewController:vc animated:NO];
    self.albumContentController = vc;
}

- (void)changedAlbumContentController{
    if (self.albumContentController) {
        PHAssetCollection *assetCollection = [self.groupList objectAtIndex:self.albumContentController.indexPath.row];
        self.albumContentController.assetCollection = assetCollection;
    }
}

#pragma mark - PHPhotoLibraryChangeObserver
- (void)photoLibraryDidChange:(PHChange *)changeInstance{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    if ((timeInterval - self.lastChangeTimeInterval) > 2) {
        self.lastChangeTimeInterval = timeInterval;
        [self getAssetCollections];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    return self.groupList.count;
    return self.contentGroupList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AlbumGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AlbumGroupTableViewCell" forIndexPath:indexPath];
//    PHAssetCollection *assetCollection = [self.groupList objectAtIndex:indexPath.row];
    PHAssetCollection *assetCollection = [self.contentGroupList objectAtIndex:indexPath.row];
    cell.data = assetCollection;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    PHAssetCollection *assetCollection = [self.groupList objectAtIndex:indexPath.row];
    PHAssetCollection *assetCollection = [self.contentGroupList objectAtIndex:indexPath.row];
    XYAlbumContentViewController *vc = [[XYAlbumContentViewController alloc] initWithNibName:@"XYAlbumContentViewController" bundle:nil];
    vc.indexPath = indexPath;
    vc.delegate = self;
    vc.assetCollection = assetCollection;
    [self.navigationController pushViewController:vc animated:YES];
    self.albumContentController = vc;
}

#pragma mark - XYAlbumContentControllerDelegate
/**
 TODO:相册照片获取
 
 @param images 图片列表
 */
- (void)didFinishAlbumContentPickingImages:(NSArray *)images{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishAlbumGroupPickingImages:)]) {
        [self.delegate didFinishAlbumGroupPickingImages:images];
    }
}

/**
 TODO:相册视频获取
 
 @param vedios 视频列表
 */
- (void)didFinishAlbumContentPickingVedios:(NSArray *)vedios{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didFinishAlbumGroupPickingVedios:)]) {
        [self.delegate didFinishAlbumGroupPickingVedios:vedios];
    }
}

@end
