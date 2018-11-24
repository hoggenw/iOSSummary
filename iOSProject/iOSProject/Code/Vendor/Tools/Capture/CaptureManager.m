//
//  CaptureManager.m
//  IFlyFaceDemo
//
//  Created by 付正 on 16/3/1.
//  Copyright (c) 2016年 fuzheng. All rights reserved.
//

#import "CaptureManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <OpenGLES/EAGL.h>
#import <Endian.h>
//#import "UIImage+Extensions.h"
#import "PermissionDetector.h"
#import "IFlyFaceImage.h"
#import "DemoPreDefine.h"
//custom Context
static void * SessionRunningAndDeviceAuthorizedContext = &SessionRunningAndDeviceAuthorizedContext;

@interface CaptureManager ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVAssetWriteManagerDelegate>


@property (nonatomic, assign) FMVideoViewType viewType;
@property (nonatomic, assign) FMRecordState recordState;

@end

@implementation CaptureManager

@synthesize session;
@synthesize previewLayer;

#pragma mark - Capture Session Configuration

- (id)init
{
    if ((self = [super init])) {
        self.session=[[AVCaptureSession alloc] init];
        if ([self.session canSetSessionPreset:AVCaptureSessionPresetHigh]) {//设置分辨率
            self.session.sessionPreset=AVCaptureSessionPresetHigh;
        }
        _viewType = TypeFullScreen;
        self.lockInterfaceRotation=NO;
        self.previewLayer=[[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return self;
}

- (void)dealloc
{
    [self teardown];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

#pragma mark -
- (void)setup
{
    // Check for device authorization
    [self checkDeviceAuthorizationStatus];
    //1.清除存储文件地址
    [self setUpInit];
    
    
    // 这里使用CoreMotion来获取设备方向以兼容iOS7.0设备
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = .2;
    self.motionManager.gyroUpdateInterval = .2;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                        withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                            if (!error) {
                                                [self updateAccelertionData:accelerometerData.acceleration];
                                            }
                                            else{
                                                NSLog(@"%@", error);
                                            }
                                        }];
    
    // session
    dispatch_queue_t sessionQueue = dispatch_queue_create("session queue", DISPATCH_QUEUE_SERIAL);
    [self setSessionQueue:sessionQueue];
    
    dispatch_async(sessionQueue, ^{
        [self setBackgroundRecordingID:UIBackgroundTaskInvalid];
        [self.session beginConfiguration];
        
        if([session canSetSessionPreset:AVCaptureSessionPreset640x480]){
            [session setSessionPreset:AVCaptureSessionPreset640x480];
        }
        ///2. 设置视频的输入 =====
        NSError *error = nil;
        AVCaptureDevice *videoDevice = [CaptureManager deviceWithMediaType:AVMediaTypeVideo preferringPosition:AVCaptureDevicePositionFront];
        
        //input device
        AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
        if (error){
            NSLog(@"%@", error);
        }
        if ([session canAddInput:videoDeviceInput]){
            [session addInput:videoDeviceInput];
            [self setVideoDeviceInput:videoDeviceInput];
        }
        ///2. 设置视频的输入 =====结束
        
        ///3. 设置音频的输入 ======展示不需要
        ///3. 设置音频的输入 ======
        
        ///4.添加写入文件的fileoutput ======
         //output device
        AVCaptureVideoDataOutput *videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
        videoDataOutput.alwaysDiscardsLateVideoFrames = YES;
        if ([session canAddOutput:videoDataOutput]){
            [session addOutput:videoDataOutput];
            AVCaptureConnection *connection = [videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
            if ([connection isVideoStabilizationSupported]){
               connection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
            }
            
            if ([connection isVideoOrientationSupported]){
                connection.videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
            }
            
              ///4.添加写入文件的fileoutput ======
            
            // Configure your output.
            
           self.videoDataOutputQueue = dispatch_queue_create("videoDataOutput", NULL);
            [videoDataOutput setSampleBufferDelegate:self queue:self.videoDataOutputQueue];
            // Specify the pixel format
            
            //获取灰度图像数据
            videoDataOutput.videoSettings =[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]forKey:(id)kCVPixelBufferPixelFormatTypeKey];
            [self setVideoDataOutput:videoDataOutput];
        }
        
        [self.session commitConfiguration];
        
    });
    
}

//初始化设置
- (void)setUpInit
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBack) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(becomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
    [self clearFile];
     // _recordState = FMRecordStateInit;

}
-(NSString *)recordVideoPath{
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , true).firstObject;
    //NSString * name = [self randomUpperCaseString: 32];
    NSString * pathString = [NSString stringWithFormat:@"%@/%@.mp4", documentsPath,RECORDFILRSTRINGNAME];
    return  pathString;
}

//-(NSString *)randomUpperCaseString:(NSInteger )length{
//    NSMutableString *resultString = [NSMutableString string];
//    for (int i = 0; i < length;  i++) {
//        NSInteger randomNumber = arc4random()%26 + 65;
//        NSString * randomChar = [NSString stringWithFormat:@"%c",randomNumber];
//        [resultString appendString: randomChar];
//        
//    }
//    NSLog(@"随机文件名：%@",resultString);
//    return resultString;
//}

#pragma  mark - TODO
- (void)enterBack
{
    self.videoUrl = nil;
    [self.session stopRunning];
     [self.writeManager stopWrite];
    [self.writeManager destroyWrite];
}
#pragma  mark - TODO
- (void)becomeActive
{
    [self reset];
}

//清空文件夹
- (void)clearFile
{
    NSString * path = [self recordVideoPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath: path]) {
        if ([[NSFileManager defaultManager] removeItemAtPath:path error: nil]) {
           // NSLog(@"删除文件%@成功",path);
//            if ([self creatFileWithPath: path]) {
//                NSLog(@"新文件创建成果");
//            }
        }
    }
}

//创建文件
-(BOOL)creatFileWithPath:(NSString *)filePath
{
    BOOL isSuccess = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL temp = [fileManager fileExistsAtPath:filePath];
    if (temp) {
        return YES;
    }
    NSError *error;
    //stringByDeletingLastPathComponent:删除最后一个路径节点
    NSString *dirPath = [filePath stringByDeletingLastPathComponent];
    isSuccess = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"creat File Failed. errorInfo:%@",error);
    }
    if (!isSuccess) {
        return isSuccess;
    }
    isSuccess = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    return isSuccess;
}

- (void)teardown
{
    [self.session stopRunning];
    self.videoDeviceInput=nil;
    self.videoDataOutput=nil;
    self.videoDataOutputQueue=nil;
    self.sessionQueue=nil;
    [self.previewLayer removeFromSuperlayer];
    self.session=nil;
    self.previewLayer=nil;
    
    [self.motionManager stopAccelerometerUpdates];
    self.motionManager=nil;
    
}

- (void)addObserver
{
    dispatch_async([self sessionQueue], ^{
        [self addObserver:self forKeyPath:@"sessionRunningAndDeviceAuthorized" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:SessionRunningAndDeviceAuthorizedContext];
        
        __weak CaptureManager *weakSelf = self;
        [self setRuntimeErrorHandlingObserver:[[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureSessionRuntimeErrorNotification object:self.session queue:nil usingBlock:^(NSNotification *note) {
            CaptureManager *strongSelf = weakSelf;
            dispatch_async(strongSelf.sessionQueue, ^{
                // Manually restarting the session since it must have been stopped due to an error.
                [strongSelf.session startRunning];
            });
        }]];
        [self.session startRunning];
        [self setUpWriter];
    });
}

- (void)setUpWriter
{
    self.videoUrl = [self recordVideoPath];
    self.writeManager = [[AVAssetWriteManager alloc] initWithURL:[[NSURL alloc] initFileURLWithPath: self.videoUrl] viewType:_viewType];
    self.writeManager.delegate = self;
    [self startRecord];

}

#pragma mark - 自动停止的地方
- (void)finishWriting
{
  
    [self.writeManager stopWrite];
    [self.writeManager destroyWrite];
    self.writeManager = nil;
    //[self.session stopRunning];
    self.recordState = FMRecordStateFinish;

    if ([self.delegate respondsToSelector:@selector(timeOverForRecord)]) {
        [self.delegate timeOverForRecord];
    }
    [self reset];
}

- (void)updateWritingProgress:(CGFloat)progress { 
    
}


- (void)startRecord
{
    if (self.recordState == FMRecordStateInit) {
        [self.writeManager startWrite];
        self.recordState = FMRecordStateRecording;
        NSLog(@"开始录制： %@",self.videoUrl);

    }
}

- (void)stopRecord
{

    [self.writeManager stopWrite];
    [self.session stopRunning];
    self.recordState = FMRecordStateFinish;
    if ([self.delegate respondsToSelector:@selector(onOutputSourceString:)]) {
        [self.delegate onOutputSourceString: self.videoUrl];
    }


}

- (void)reset
{
    self.recordState = FMRecordStateInit;
//    [self.session startRunning];
    [self clearFile];
    [self setUpWriter];
}

- (void)removeObserver
{
    dispatch_async(self.sessionQueue, ^{
        [self.session stopRunning];
        
        [[NSNotificationCenter defaultCenter] removeObserver:[self runtimeErrorHandlingObserver]];
        [self removeObserver:self forKeyPath:@"sessionRunningAndDeviceAuthorized" context:SessionRunningAndDeviceAuthorizedContext];
    });
}

#pragma mark -
-(BOOL)isSessionRunningAndDeviceAuthorized
{
    return [self.session isRunning] && [self isDeviceAuthorized];
}

+ (NSSet *)keyPathsForValuesAffectingSessionRunningAndDeviceAuthorized
{
    return [NSSet setWithObjects:@"session.running", @"deviceAuthorized", nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == SessionRunningAndDeviceAuthorizedContext){
        BOOL boolValue = [change[NSKeyValueChangeNewKey] boolValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            CaptureContextType type=CaptureContextTypeRunningAndDeviceAuthorized;
            if(self.delegate && [self.delegate respondsToSelector:@selector(observerContext:Changed:)]){
                [self.delegate observerContext:type Changed:boolValue];
            }
        });
    }
    else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

// Create a IFlyFaceImage from sample buffer data
- (IFlyFaceImage *) faceImageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer
{
    //获取灰度图像数据
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    
    uint8_t *lumaBuffer  = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);
    
    size_t bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer,0);
    size_t width  = CVPixelBufferGetWidth(pixelBuffer);
    size_t height = CVPixelBufferGetHeight(pixelBuffer);
    
    CGColorSpaceRef grayColorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef context=CGBitmapContextCreate(lumaBuffer, width, height, 8, bytesPerRow, grayColorSpace,0);
    CGImageRef cgImage = CGBitmapContextCreateImage(context);

    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    
    IFlyFaceDirectionType faceOrientation=[self faceImageOrientation];
    
    IFlyFaceImage* faceImage=[[IFlyFaceImage alloc] init];
    if(!faceImage){
        return nil;
    }

    CGDataProviderRef provider = CGImageGetDataProvider(cgImage);
    
    faceImage.data= (__bridge_transfer NSData*)CGDataProviderCopyData(provider);
    faceImage.width=width;
    faceImage.height=height;
    faceImage.direction=faceOrientation;
    
    CGImageRelease(cgImage);
    CGContextRelease(context);
    CGColorSpaceRelease(grayColorSpace);
    
    return faceImage;
    
}

+ (AVCaptureVideoOrientation)interfaceOrientationToVideoOrientation:(UIInterfaceOrientation)orientation
{
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            return AVCaptureVideoOrientationPortrait;
        case UIInterfaceOrientationPortraitUpsideDown:
            return AVCaptureVideoOrientationPortraitUpsideDown;
        case UIInterfaceOrientationLandscapeLeft:
            return AVCaptureVideoOrientationLandscapeLeft;
        case UIInterfaceOrientationLandscapeRight:
            return AVCaptureVideoOrientationLandscapeRight;
        default:
            break;
    }
    NSLog(@"Warning - Didn't recognise interface orientation (%ld)",(long)orientation);
    return AVCaptureVideoOrientationPortrait;
}

#pragma mark - Actions

- (void)cameraToggle
{
    dispatch_async(dispatch_get_main_queue(), ^{
        CaptureContextType type=CaptureContextTypeCameraFrontOrBackToggle;
        if(self.delegate && [self.delegate respondsToSelector:@selector(observerContext:Changed:)]){
            [self.delegate observerContext:type Changed:NO];
        }
    });
    
    dispatch_async(self.sessionQueue, ^{
        AVCaptureDevice *currentVideoDevice = self.videoDeviceInput.device;
        AVCaptureDevicePosition preferredPosition = AVCaptureDevicePositionUnspecified;
        AVCaptureDevicePosition currentPosition = [currentVideoDevice position];
        
        switch (currentPosition){
            case AVCaptureDevicePositionUnspecified:
                preferredPosition = AVCaptureDevicePositionFront;
                break;
            case AVCaptureDevicePositionBack:
                preferredPosition = AVCaptureDevicePositionFront;
                break;
            case AVCaptureDevicePositionFront:
                preferredPosition = AVCaptureDevicePositionBack;
                break;
        }
        
        AVCaptureDevice *videoDevice = [CaptureManager deviceWithMediaType:AVMediaTypeVideo preferringPosition:preferredPosition];
        AVCaptureDeviceInput *videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
        
        
        [self.session beginConfiguration];
        
        [self.session removeInput:self.videoDeviceInput];
        if ([self.session canAddInput:videoDeviceInput]){
            [self.session addInput:videoDeviceInput];
            [self setVideoDeviceInput:videoDeviceInput];
        }
        else{
            [self.session addInput:self.videoDeviceInput];
        }
        
        if([self.session canSetSessionPreset:AVAssetExportPreset640x480]){
            [self.session setSessionPreset:AVAssetExportPreset640x480];
        }
        
        [self.session commitConfiguration];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CaptureContextType type=CaptureContextTypeCameraFrontOrBackToggle;
            if(self.delegate && [self.delegate respondsToSelector:@selector(observerContext:Changed:)]){
                [self.delegate observerContext:type Changed:YES];
            }
        });
    });
}

#pragma mark - VideoData OutputSampleBuffer Delegate
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(onOutputFaceImage:)]){
        IFlyFaceImage* faceImage=[self faceImageFromSampleBuffer:sampleBuffer];
        [self.delegate onOutputFaceImage:faceImage];
        faceImage=nil;
    }
    @autoreleasepool {
        
        //视频
        if (connection == [self.videoDataOutput connectionWithMediaType:AVMediaTypeVideo]) {
            
            if (!self.writeManager.outputVideoFormatDescription) {
                @synchronized(self) {
                    CMFormatDescriptionRef formatDescription = CMSampleBufferGetFormatDescription(sampleBuffer);
                    self.writeManager.outputVideoFormatDescription = formatDescription;
                }
            } else {
                @synchronized(self) {
                    if (self.writeManager.writeState == FMRecordStateRecording) {
                        [self.writeManager appendSampleBuffer:sampleBuffer ofMediaType:AVMediaTypeVideo];
                    }
                    
                }
            }
            
            
        }
    }
}

#pragma mark - Device Configuration

+ (AVCaptureDevice *)deviceWithMediaType:(NSString *)mediaType preferringPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:mediaType];
    AVCaptureDevice *captureDevice = [devices firstObject];
    
    for (AVCaptureDevice *device in devices){
        if ([device position] == position){
            captureDevice = device;
            break;
        }
    }
    
    return captureDevice;
}

#pragma mark - UI

-(void)showAlert:(NSString*)info
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:info delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    alert=nil;
}

- (void)checkDeviceAuthorizationStatus
{
    if([PermissionDetector isCapturePermissionGranted]){
        [self setDeviceAuthorized:YES];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString* info=@"没有相机权限";
            [self showAlert:info];
            [self setDeviceAuthorized:NO];
        });
    }
}


#pragma mark - tool
- (void)updateAccelertionData:(CMAcceleration)acceleration
{
    UIInterfaceOrientation orientationNew;
    
    if (acceleration.x >= 0.75) {
        orientationNew = UIInterfaceOrientationLandscapeLeft;
    }
    else if (acceleration.x <= -0.75) {
        orientationNew = UIInterfaceOrientationLandscapeRight;
    }
    else if (acceleration.y <= -0.75) {
        orientationNew = UIInterfaceOrientationPortrait;
    }
    else if (acceleration.y >= 0.75) {
        orientationNew = UIInterfaceOrientationPortraitUpsideDown;
    }
    else {
        // Consider same as last time
        return;
    }
    
    if (orientationNew == self.interfaceOrientation)
        return;
    
    self.interfaceOrientation = orientationNew;
}

-(IFlyFaceDirectionType)faceImageOrientation
{
    IFlyFaceDirectionType faceOrientation=IFlyFaceDirectionTypeLeft;
    BOOL isFrontCamera=self.videoDeviceInput.device.position==AVCaptureDevicePositionFront;
    switch (self.interfaceOrientation) {
        case UIDeviceOrientationPortrait:{//
            faceOrientation=IFlyFaceDirectionTypeLeft;
        }
            break;
        case UIDeviceOrientationPortraitUpsideDown:{
            faceOrientation=IFlyFaceDirectionTypeRight;
        }
            break;
        case UIDeviceOrientationLandscapeRight:{
            faceOrientation=isFrontCamera?IFlyFaceDirectionTypeUp:IFlyFaceDirectionTypeDown;
        }
            break;
        default:{//
            faceOrientation=isFrontCamera?IFlyFaceDirectionTypeDown:IFlyFaceDirectionTypeUp;
        }
            break;
    }
    
    return faceOrientation;
}

@end
