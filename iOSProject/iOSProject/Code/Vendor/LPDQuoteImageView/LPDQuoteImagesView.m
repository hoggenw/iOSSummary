//
//  LPDQuoteImagesView.m
//  LPDQuoteImagesController
//
//  Created by Assuner on 2016/12/16.
//  Copyright © 2016年 Assuner. All rights reserved.
//

#import "LPDQuoteImagesView.h"
#import "UpLoadDataModel.h"
#import "YLUIDocumentPickerViewViewController.h"


@interface LPDQuoteImagesView ()<LPDImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIDocumentPickerDelegate>

{
  CGFloat _itemWH;
};

//@property (assign, nonatomic) BOOL isSelectOriginalPhoto;            ///是否选了原图

@property (assign, nonatomic) NSUInteger countPerRowInView;           ///view每行照片数
@property (assign, nonatomic) UpLoadDataModel * chioceModel;
@property (assign, nonatomic) NSUInteger chioceRow;

@property (assign, nonatomic) CGFloat margin;                         ///已选图片页面Cell的间距
@property (assign, nonatomic) UIEdgeInsets contentInsets;             ///collectionView的edge配置

@property (strong, nonatomic) UIImagePickerController *imagePickerVc; ///系统的picker，调用相机


@end

@implementation LPDQuoteImagesView

- (instancetype)initWithFrame:(CGRect)frame withCountPerRowInView:(NSUInteger)ArrangeCount cellMargin:(CGFloat)cellMargin{
  if(self = [super initWithFrame: frame]){
    self.backgroundColor = [UIColor clearColor];
    _selectedPhotos = [[NSMutableArray alloc] init];
    _selectedAssets = [[NSMutableArray alloc] init];
      _chioceRow = -1;
    
    _maxSelectedCount = 9;
    _countPerRowInView = 5;
    _countPerRowInAlbum = 4;
    _margin = 12;
    _contentInsets = UIEdgeInsetsMake(12, 4, 12, 8);
    
    if(ArrangeCount > 0){
      _countPerRowInView = ArrangeCount;
    }
    
    if(cellMargin > 0){
      _margin = cellMargin;
      _contentInsets = UIEdgeInsetsMake(10, _margin/2-2, 0, _margin/2+2);
    }
    [self configCollectionView];
  }
  return self;
}


- (UIImagePickerController *)imagePickerVc {///系统的picker，可调用相机
  if (_imagePickerVc == nil) {
    _imagePickerVc = [[UIImagePickerController alloc] init];
    _imagePickerVc.delegate = self;
    
    UIBarButtonItem *lpdBarItem, *BarItem;
    if (iOS9Later) {
      lpdBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[LPDImagePickerController class]]];
      BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
    } else {
      lpdBarItem = [UIBarButtonItem appearanceWhenContainedIn:[LPDImagePickerController class], nil];
      BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
    }
    NSDictionary *titleTextAttributes = [lpdBarItem titleTextAttributesForState:UIControlStateNormal];
    [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
  }
  return _imagePickerVc;
}

- (BOOL)prefersStatusBarHidden {
  return NO;
}


- (void)configCollectionView {
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  /**********LPDPhotoArrangeCVlLayout******** 拖动排序用这个**********************/
  
  _itemWH = self.lpd_width / _countPerRowInView - _margin;
  layout.itemSize = CGSizeMake(_itemWH, _itemWH);
  layout.minimumInteritemSpacing = _margin;
  layout.minimumLineSpacing = _margin;
  _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.lpd_width, self.lpd_height) collectionViewLayout:layout];
  _collectionView.alwaysBounceVertical = YES;
  _collectionView.backgroundColor = [UIColor clearColor];
  _collectionView.contentInset = _contentInsets;
  _collectionView.dataSource = self;
  _collectionView.delegate = self;
  _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
  [self addSubview:_collectionView];
  [_collectionView registerClass:[LPDPhotoArrangeCell class] forCellWithReuseIdentifier:@"LPDPhotoArrangeCell"];
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  if(_selectedPhotos.count < 3) {
    return _selectedPhotos.count + 1;
  }else {
    return _selectedPhotos.count  ;
  }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LPDPhotoArrangeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPDPhotoArrangeCell" forIndexPath:indexPath];
    cell.videoThumbnail.hidden = YES;
    cell.imageThumbnail.hidden = false;
    cell.showLabel.hidden = true;
    cell.nookDeleteBtn.hidden = false;
  if(_selectedPhotos.count< 3) {
    if (indexPath.row == _selectedPhotos.count) {
      [cell.imageThumbnail setImage:[UIImage imageNamedFromMyBundle:@"AlbumAddBtn.png"]];//
      cell.imageThumbnail.layer.borderWidth = 2;
      cell.nookDeleteBtn.hidden = YES;
      
    } else {
      UpLoadDataModel *model = _selectedPhotos[indexPath.row];
        if ([model.dataType isEqualToString:@"image/jpg/png/jpeg"] || [model.dataType isEqualToString:@"jpg"] || [model.dataType isEqualToString:@"png"] || [model.dataType isEqualToString:@"jpeg"]) {
            if (model.url.absoluteString.length > 0) {
                [cell.imageThumbnail sd_setImageWithURL: model.url];
            }else{
                cell.imageThumbnail.image = [UIImage imageWithData: model.data];
            }
  
            //cell.asset = _selectedAssets[indexPath.row];
            cell.imageThumbnail.layer.borderWidth = 0;
            cell.nookDeleteBtn.hidden = NO;
        }else{
            cell.imageThumbnail.hidden = true;
            cell.showLabel.hidden = false;
            cell.showLabel.text = model.showName;
        }
    }
  }else {
      UpLoadDataModel *model = _selectedPhotos[indexPath.row];
      if ([model.dataType isEqualToString:@"image/jpg/png/jpeg"] || [model.dataType isEqualToString:@"jpg"] || [model.dataType isEqualToString:@"png"] || [model.dataType isEqualToString:@"jpeg"]) {
          if (model.url.absoluteString.length > 0) {
              [cell.imageThumbnail sd_setImageWithURL: model.url];
          }else{
              cell.imageThumbnail.image = [UIImage imageWithData: model.data];
          }
          //cell.asset = _selectedAssets[indexPath.row];
          cell.imageThumbnail.layer.borderWidth = 0;
          cell.nookDeleteBtn.hidden = NO;
      }else{
          cell.imageThumbnail.hidden = true;
          cell.showLabel.hidden = false;
          cell.showLabel.text = model.showName;
      }
  }
    [cell bringSubviewToFront: cell.nookDeleteBtn];
    cell.nookDeleteBtn.tag = indexPath.row;
    [cell.nookDeleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
  
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   NSLog(@"self.selectedPhotos.count  : %@",@(self.selectedPhotos.count));
    if (self.selectedPhotos.count  == indexPath.row || self.selectedPhotos.count == 0) {
        self.maxSelectedCount = 3 - self.selectedPhotos.count;
    }else{
        self.maxSelectedCount = 1;
        self.chioceModel = self.selectedPhotos[indexPath.row];
        self.chioceRow = indexPath.row;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"文件" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
            //older than iOS 8 code here
            NSLog(@"IOS8以上才支持icloud drive.");
        } else {
            //iOS 8 specific code here
            NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt"];
            
            YLUIDocumentPickerViewViewController *documentPicker = [[YLUIDocumentPickerViewViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeImport];
            documentPicker.delegate = self;
            documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
            [[self viewControllerSupportView: self]  presentViewController:documentPicker animated: true completion:nil];
        }
        
    }];
    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        [self pushImagePickerController];
//        if (indexPath.row == self.selectedPhotos.count) {
//
//
//
//        } else { //预览照片或者视频
//            id asset = self.selectedAssets[indexPath.row];
//            BOOL isVideo = NO;
//            if ([asset isKindOfClass:[PHAsset class]]) {
//                PHAsset *phAsset = asset;
//                isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
//            } else if ([asset isKindOfClass:[ALAsset class]]) {
//                ALAsset *alAsset = asset;
//                isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
//            }
//            if (isVideo) { // 预览视频
//                LPDVideoPlayerController *vc = [[LPDVideoPlayerController alloc] init];
//                LPDAssetModel *model = [LPDAssetModel modelWithAsset:asset type:LPDAssetModelMediaTypeVideo timeLength:@""];
//                vc.model = model;
//                [self.navcDelegate presentViewController:vc animated:YES completion:nil];
//            } else { // 预览照片
//                LPDImagePickerController *selectImagePickerVc = [[LPDImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
//                selectImagePickerVc.maxImagesCount = self.maxSelectedCount;
//                selectImagePickerVc.allowPickingOriginalPhoto = NO;
//
//                [selectImagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//                    UIImage * image = photos.firstObject;
//                    UpLoadDataModel * model = [UpLoadDataModel new];
//                    model.data = UIImageJPEGRepresentation(image, 0.8);
//                    model.showName = @"";
//                    model.dataType = @"image/jpg/png/jpeg";
//                    [self.selectedPhotos removeObjectAtIndex: self.chioceRow];
//                    [self.selectedPhotos insertObject: model atIndex: self.chioceRow];
//
//                    self.selectedAssets = [NSMutableArray arrayWithArray:assets];
//                    [self.collectionView reloadData];
//                    self.collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
//                }];
//                [self.navcDelegate presentViewController:selectImagePickerVc animated:YES completion:nil];
            //}
//        }
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:cameraAction];
    [alertController addAction:pictureAction];
    
    [[self viewControllerSupportView: self] presentViewController:alertController animated:YES completion:nil];

}
#pragma mark - cloud drive delegate
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    //NSLog(@"url: %@,[[url path] lastPathComponent]]:%@",url,[[url path] lastPathComponent]);
    NSData *data = [NSData dataWithContentsOfURL:url];//url是本地文件URL，文档的内容将复制到应用的tmp/DocumentPickerIncoming文件夹中
    if (data.length > 3145728) {
        [YLHintView showMessageOnThisPage:@"所选文件不能大于3M"];
        return;
    }
    //NSLog(@"data.lenth: %@",@(data.length));
    UpLoadDataModel * model = [UpLoadDataModel new];
    model.data = data;
    NSString * typeString = [[[url path] lastPathComponent] componentsSeparatedByString:@"."].lastObject;
    //NSLog(@"typeString :%@",typeString);
    if ([typeString isEqualToString:@"docx"]) {
      model.dataType = @"application/msword";
    }else if ([typeString isEqualToString:@"pdf"]){
        model.dataType = @"application/pdf";
    }
    else if ([typeString isEqualToString:@"jpg"] || [typeString isEqualToString:@"png"] || [typeString isEqualToString:@"jpeg"]){
        model.dataType = @"image/jpg/png/jpeg";
    }
    model.showName = [[url path] lastPathComponent];
    model.url = url;

    if (self.chioceRow != -1) {
        [self.selectedPhotos removeObjectAtIndex: self.chioceRow];
        [self.selectedPhotos insertObject: model atIndex: self.chioceRow];
        self.chioceRow = -1;
    }else{
        [self.selectedPhotos addObject: model];
    }
    
    
    [self.collectionView reloadData];
    
//    BOOL fileUrlAuthozied = [url startAccessingSecurityScopedResource];
//    if(fileUrlAuthozied){
//        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
//        NSError *error;
//
//        [fileCoordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
//            NSLog(@"newURL: %@,[[url path] lastPathComponent]]:%@",newURL,[[url path] lastPathComponent]);
//            //[self dismissViewControllerAnimated:YES completion:NULL];
////            [self sendFileMessageWithURL:newURL displayName:[[url path] lastPathComponent]];
//        }];
//        [url stopAccessingSecurityScopedResource];
//    }else{
//        //Error handling
//
//    }
}



- (UIViewController *)viewControllerSupportView:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - LPDPhotoArrangeCVDataSource

/// 长按排序相关代码
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
  return indexPath.item < _selectedPhotos.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
  return (sourceIndexPath.item < _selectedPhotos.count && destinationIndexPath.item < _selectedPhotos.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
  UpLoadDataModel *model = _selectedPhotos[sourceIndexPath.item];
  [_selectedPhotos removeObjectAtIndex:sourceIndexPath.item];
  [_selectedPhotos insertObject:model atIndex:destinationIndexPath.item];
  
//  id asset = _selectedAssets[sourceIndexPath.item];
//  [_selectedAssets removeObjectAtIndex:sourceIndexPath.item];
//  [_selectedAssets insertObject:asset atIndex:destinationIndexPath.item];
  
  [_collectionView reloadData];
}
//
- (void)pushImagePickerController {
  if (self.maxSelectedCount <= 0) {
    return;
  }
  
  LPDImagePickerController *lpdImagePickerVc = [[LPDImagePickerController alloc] initWithMaxImagesCount:self.maxSelectedCount columnNumber:self.countPerRowInAlbum delegate:self pushPhotoPickerVc:YES];
  lpdImagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
  lpdImagePickerVc.allowPickingVideo = NO;
  lpdImagePickerVc.allowPickingOriginalPhoto = NO;
  lpdImagePickerVc.sortAscendingByModificationDate = NO;
  
  if (self.maxSelectedCount > 1) {
    // 设置目前已经选中的图片数组去初始化picker
    //lpdImagePickerVc.selectedAssets = _selectedAssets;
    lpdImagePickerVc.showSelectBtn = NO;
    
  }else {
    lpdImagePickerVc.showSelectBtn = YES;
  }
  
  [self.navcDelegate presentViewController:lpdImagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
  UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
  if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
    self.imagePickerVc.sourceType = sourceType;
    if(iOS8Later) {
      _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    [self.navcDelegate presentViewController:_imagePickerVc animated:YES completion:nil];
  } else {
    NSLog(@"模拟器中无法打开照相机,请在真机中使用");
  }
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  [picker dismissViewControllerAnimated:YES completion:nil];
  NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
  if ([type isEqualToString:@"public.image"]) {
    LPDImagePickerController *lpdImagePickerVc = [[LPDImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    lpdImagePickerVc.sortAscendingByModificationDate = YES;
    [lpdImagePickerVc showProgressHUD];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //  保存图片，获取到asset
    if (!image) {
      return;
    }
    [[LPDImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
      if (error) {
        [lpdImagePickerVc hideProgressHUD];
        NSLog(@"图片保存失败 %@",error);
      } else {
        [[LPDImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(LPDAlbumModel *model) {
          [[LPDImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<LPDAssetModel *> *models) {
            [lpdImagePickerVc hideProgressHUD];
            LPDAssetModel *assetModel = [models firstObject];
            if (lpdImagePickerVc.sortAscendingByModificationDate) {
              assetModel = [models lastObject];
            }
            
            [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
            
          }];
        }];
      }
    }];
  }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    [_selectedAssets addObject:asset];
    UpLoadDataModel * model = [UpLoadDataModel new];
    model.data = UIImageJPEGRepresentation(image, 0.8);
    model.showName = @"图片资源.jpeg";
    model.dataType = @"image/jpg/png/jpeg";
    [_selectedPhotos addObject:model];
    [_collectionView reloadData];
  
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  if ([picker isKindOfClass:[UIImagePickerController class]]) {
    [picker dismissViewControllerAnimated:YES completion:nil];
  }
}



#pragma mark - LPDImagePickerControllerDelegate


/// 用户点击了取消 代理
- (void)lpd_imagePickerControllerDidCancel:(LPDImagePickerController *)picker {
  NSLog(@"cancel");
}


// lpdImagePicker每次选照片后的保存和更新操作
- (void)imagePickerController:(LPDImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    NSInteger count = photos.count;
    if (photos.count > self.maxSelectedCount) {
        count = self.maxSelectedCount;
    }
    if (photos.count == 1 && self.chioceRow != -1) {
        UIImage * image = photos.firstObject;
        UpLoadDataModel * model = [UpLoadDataModel new];
        model.data = UIImageJPEGRepresentation(image, 0.8);
        model.showName =  @"图片资源.jpeg";
        model.dataType = @"image/jpg/png/jpeg";
        [self.selectedPhotos removeObjectAtIndex: self.chioceRow];
        [self.selectedPhotos insertObject: model atIndex: self.chioceRow];
        self.chioceRow = -1;
        [_collectionView reloadData];
        return;
    }
    for (int i = 0; i < count ; i ++) {
        UIImage * image = photos[i];
        UpLoadDataModel * model = [UpLoadDataModel new];
        model.data = UIImageJPEGRepresentation(image, 0.8);
        model.showName =  @"图片资源.jpeg";
        model.dataType = @"image/jpg/png/jpeg";
        [_selectedPhotos addObject: model];
    }
 // _selectedPhotos = [NSMutableArray arrayWithArray:photos];
  _selectedAssets = [NSMutableArray arrayWithArray:assets];
  
  [_collectionView reloadData];
  
  //test**********[self printAssetsName:assets];
}

// 选择了一个视频的代理方法
- (void)imagePickerController:(LPDImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
  _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
//  _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
  
  /*************** 打开这段代码发送视频
   [[LPDImageManager manager] getVideoOutputPathWithAsset:asset completion:^(NSString *outputPath) {
   NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
   }]; ***********************/
  
  [_collectionView reloadData];
}

#pragma mark - DeleteBtn
- (void)deleteBtnClik:(UIButton *)sender {
  [_selectedPhotos removeObjectAtIndex:sender.tag];
//  [_selectedAssets removeObjectAtIndex:sender.tag];
    NSLog(@"_selectedPhotos.count: %@",@(_selectedPhotos.count));
        [_collectionView reloadData];
//  if(_selectedPhotos.count == _maxSelectedCount - 1){
//
//  }else{
//    [_collectionView performBatchUpdates:^{
//      NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
//      [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
//    } completion:^(BOOL finished) {
//      [_collectionView reloadData];
//    }];
//  }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
  return UIInterfaceOrientationMaskPortrait;
}

@end
