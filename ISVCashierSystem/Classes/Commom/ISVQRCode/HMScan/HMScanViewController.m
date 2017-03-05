//
//  HMScanViewController.m
//  HealthMall
//
//  Created by johnWu on 15/11/12.
//  Copyright © 2015年 HealthMall. All rights reserved.
//

#import "HMScanViewController.h"
#import "AVCaptureSession+ZZYQRCodeAndBarCodeExtension.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "HMQRCodeTool.h"

#import "UIBarButtonItem+HMExtension.h"
#import "HMHUD.h"

#define previewWH 250.0 // 扫描范围

@interface HMScanViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *scanTop;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) AVCaptureSession *session;
//@property (nonatomic, weak) UIButton *openTorchButton;// 闪关灯

@end

@implementation HMScanViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"扫一扫";
    self.view.backgroundColor = HMBackgroundColor;
    
    //设置为当前的宽高
    self.view.frame = kSCREEN_BOUNDS;
    
    // 添加跟屏幕刷新频率一样的定时器
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(scan)];
    self.link = link;
    // 获取读取读取二维码的会话
    self.session = [AVCaptureSession readQRCodeWithMetadataObjectsDelegate:self];
    
    // 扫描识别范围
    AVCaptureMetadataOutput *output = [[self.session outputs] firstObject];
    output.rectOfInterest = CGRectMake((self.view.bounds.size.height - previewWH) * 0.5 / self.view.bounds.size.height,(self.view.bounds.size.width - previewWH) * 0.5  / self.view.bounds.size.width,previewWH / self.view.bounds.size.height,previewWH / self.view.bounds.size.width);
    
    // 创建预览图层
    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    previewLayer.backgroundColor = [UIColor redColor].CGColor;
    previewLayer.frame = self.view.bounds;
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    
    [self setUpNav];
}

// 初始化导航条
- (void)setUpNav
{
    // 1.关闭按钮
//    UIImage *close = [UIImage imageNamed:@"Nav_Button_close"];
//    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithImage:close style:0 target:self action:@selector(closeItemPressed)];
    
    // 1.返回按钮
    UIBarButtonItem *closeItem = [UIBarButtonItem backBarButtonItemWithTitle:nil target:self action:@selector(closeItemPressed)];
    
    self.navigationItem.leftBarButtonItem = closeItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}


// 在页面将要显示的时候添加定时器
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.session startRunning];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

// 在页面将要消失的时候移除定时器
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}
// 扫描动画
- (void)scan{
    self.scanTop.constant -= 2;
    if (self.scanTop.constant <= -170) {
        self.scanTop.constant = 170;
    }
}


#pragma mark ---------------------AVCaptureMetadataOutputObjectsDelegate--------------------

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects.count > 0) {
        
        // 获取信息
        AVMetadataMachineReadableCodeObject *object = metadataObjects.lastObject;
        
        //扫描结果
        NSString *resultString = object.stringValue;
        
        [self playBeep];
        
        [self closeItemPressed];
        
        //如果有block有值就执行
        if(self.completeBlock){
            self.completeBlock(resultString);
        }
    }
}

#pragma mark - Public
- (void)stopScan
{
    // 停止定时
    [self.link invalidate];
    self.link = nil;
    // 停止扫描
    [self.session stopRunning];
    self.session = nil;
}

#pragma mark - Private
// 扫描震动
- (void)playBeep
{
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"beep"ofType:@"wav"]], &soundID);
        AudioServicesPlaySystemSound(soundID);

    // Vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

// 闪光灯
- (BOOL)isLightOpened
{
    // 1.获取输入设备(摄像头)
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (![device hasTorch]) {
        return NO;
    }else{
        if ([device torchMode] == AVCaptureTorchModeOn) {
            return YES;
        } else {
            return NO;
        }
    }
}

- (void)openLight:(BOOL)open
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType: AVMediaTypeVideo];//[self.reader.readerView device];
    if (![device hasTorch]) {
    } else {
        if (open) {
            // 开启闪光灯
            if(device.torchMode != AVCaptureTorchModeOn ||
               device.flashMode != AVCaptureFlashModeOn){
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                [device unlockForConfiguration];
            }
        } else {
            // 关闭闪光灯
            if(device.torchMode != AVCaptureTorchModeOff ||
               device.flashMode != AVCaptureFlashModeOff){
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                [device unlockForConfiguration];
            }
        }
    }
}

- (IBAction)openTorchButtonTouched:(id)sender {
    
    UIButton *torchBtn = sender;
    BOOL isLightOpened = [self isLightOpened];
    
    if (isLightOpened) {
        //        [torchBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"scan_flash_closed" ofType:@"png"]] forState:UIControlStateNormal];
        [torchBtn setBackgroundColor:[UIColor clearColor]];
        [torchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.openTorchButton setTitle:@"开灯"forState:UIControlStateNormal];
    }else{
            //        [torchBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"scan_flash_opened" ofType:@"png"]] forState:UIControlStateNormal];
        [torchBtn setBackgroundColor:[UIColor whiteColor]];
        [torchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.openTorchButton setTitle:@"关灯"forState:UIControlStateNormal];
    }
    
    [self openLight:!isLightOpened];
}

#pragma mark - <UIImagePickerControllerDelegate>
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    // 当选择的类型是图片
    if (!image || [type isEqualToString:@"public.movie"])
    {
        [HMHUD showErrorWithStatus:@"请选择图片"];
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    NSError *error = nil;
    NSString *resultString = [HMQRCodeTool stringFromQRCodeImage:image.CGImage error:error];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    [self closeItemPressed];
    
    // 如果有block有值就执行
    if(self.completeBlock){
        self.completeBlock(resultString);
    }
    
}
#pragma mark - Event
- (void)closeItemPressed
{
    [self stopScan];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightItemClick
{
    UIImagePickerController *pickerImageVC = [[UIImagePickerController alloc] init];
    pickerImageVC.view.backgroundColor = [UIColor whiteColor];
    pickerImageVC.delegate = self;
    pickerImageVC.allowsEditing = NO;//设置可编辑
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        pickerImageVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        // 只允许选择图片
        pickerImageVC.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeImage, nil];
    }
    [pickerImageVC setTitle:@"相册"];
    [self presentViewController:pickerImageVC animated:YES completion:nil];
}

@end
