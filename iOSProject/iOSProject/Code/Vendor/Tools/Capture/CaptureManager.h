//
//  CaptureManager.h
//  IFlyFaceDemo
//
//  Created by 付正 on 16/3/3.
//  Copyright (c) 2016年 fuzheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>
#import "AVAssetWriteManager.h"

typedef NS_ENUM(NSUInteger, CaptureContextType)
{
    CaptureContextTypeRunningAndDeviceAuthorized,
    CaptureContextTypeCameraFrontOrBackToggle
};

@class IFlyFaceImage;

@protocol CaptureManagerDelegate <NSObject>

@optional

-(void)onOutputSourceString:(NSString *)sourceString;
-(void)onOutputFaceImage:(IFlyFaceImage*)img;
-(void)observerContext:(CaptureContextType)type Changed:(BOOL)boolValue;
-(void)timeOverForRecord;

@end


@interface CaptureManager : NSObject

// delegate
@property (nonatomic,weak) id<CaptureManagerDelegate> delegate;

// Device orientation
@property (nonatomic) CMMotionManager *motionManager;


// Session management.
@property (nonatomic) dispatch_queue_t sessionQueue; // Communicate with the session and other session objects on this queue.
@property (nonatomic) AVCaptureSession *session;

@property (nonatomic) AVCaptureDeviceInput *videoDeviceInput;

@property (nonatomic) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic) dispatch_queue_t videoDataOutputQueue;

@property (nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic) UIInterfaceOrientation interfaceOrientation;

// Utilities.
@property (nonatomic) UIBackgroundTaskIdentifier backgroundRecordingID;
@property (nonatomic, getter = isDeviceAuthorized) BOOL deviceAuthorized;
@property (nonatomic, readonly, getter = isSessionRunningAndDeviceAuthorized) BOOL sessionRunningAndDeviceAuthorized;
@property (nonatomic) BOOL lockInterfaceRotation;
@property (nonatomic) id runtimeErrorHandlingObserver;
@property (nonatomic, strong, readwrite) NSString *videoUrl;
@property (nonatomic, strong)AVAssetWriteManager *writeManager;


// init CaptureSessionManager functions
- (void)setup;
- (void)teardown;
- (void)addObserver;
- (void)removeObserver;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;


// functions
- (void)cameraToggle;
+ (AVCaptureVideoOrientation)interfaceOrientationToVideoOrientation:(UIInterfaceOrientation)orientation;

- (void)startRecord;

- (void)stopRecord;

@end
