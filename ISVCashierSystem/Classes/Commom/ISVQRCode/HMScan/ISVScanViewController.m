//
//  ISVScanViewController.m
//  ISV
//
//  Created by johnWu on 15/11/12.
//  Copyright © 2017年 ISV. All rights reserved.
//

#import "ISVScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "ISVQRCodeTool.h"
#import "UIBarButtonItem+ISVExtension.h"
#import "ISVHUD.h"

#define previewWH 250.0 // 扫描范围

@interface ISVScanViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *scanTop;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, weak) UIImageView *line;
@property (nonatomic, assign) NSInteger distance;
@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, weak) IBOutlet UIButton *openTorchButton;// 闪关灯

@end

@implementation ISVScanViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"扫一扫";
    
    _distance = 0;
    // 添加跟屏幕刷新频率一样的定时器
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(scan)];
    self.link = link;
    
    [self setUpNav];
    [self creatControl];
    //设置参数
    [self setupCamera];

    
}

// 初始化导航条
- (void)setUpNav
{
    // 1.返回按钮
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:0 target:self action:@selector(closeItemPressed)];
    
    self.navigationItem.leftBarButtonItem = closeItem;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick)];
}


- (void)creatControl
{
    CGFloat scanW = kSCREEN_WIDTH * 0.65;
    CGFloat padding = 10.0f;
    CGFloat labelH = 20.0f;
    CGFloat tabBarH = 64.0f;
    CGFloat cornerW = 26.0f;
    CGFloat marginX = (kSCREEN_WIDTH - scanW) * 0.5;
    CGFloat marginY = (kSCREEN_HEIGHT - scanW - padding - labelH) * 0.5;
    
    //遮盖视图
    for (int i = 0; i < 4; i++) {
        UIView *cover = [[UIView alloc] initWithFrame:CGRectMake(0, (marginY + scanW) * i, kSCREEN_WIDTH, marginY + (padding + labelH) * i)];
        if (i == 2 || i == 3) {
            cover.frame = CGRectMake((marginX + scanW) * (i - 2), marginY, marginX, scanW);
        }
        cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        [self.view addSubview:cover];
    }
    
    //扫描视图
    UIView *scanView = [[UIView alloc] initWithFrame:CGRectMake(marginX, marginY, scanW, scanW)];
    [self.view addSubview:scanView];
    
    //扫描线
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scanW, 2)];
    [self drawLineForImageView:line];
    [scanView addSubview:line];
    self.line = line;
    
    //边框
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scanW, scanW)];
    borderView.layer.borderColor = [[UIColor whiteColor] CGColor];
    borderView.layer.borderWidth = 1.0f;
    [scanView addSubview:borderView];
    
    //扫描视图四个角
    for (int i = 0; i < 4; i++) {
        CGFloat imgViewX = (scanW - cornerW) * (i % 2);
        CGFloat imgViewY = (scanW - cornerW) * (i / 2);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(imgViewX, imgViewY, cornerW, cornerW)];
        if (i == 0 || i == 1) {
            imgView.transform = CGAffineTransformRotate(imgView.transform, M_PI_2 * i);
        }else {
            imgView.transform = CGAffineTransformRotate(imgView.transform, - M_PI_2 * (i - 1));
        }
        [self drawImageForImageView:imgView];
        [scanView addSubview:imgView];
    }
    
    //提示标签
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scanView.frame) + padding, kSCREEN_WIDTH, labelH)];
    label.text = @"将二维码/条形码放入框内，即可自动扫描";
    label.font = ISVFontSize(12);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    //选项栏
    UIView *tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT - tabBarH, kSCREEN_WIDTH, tabBarH)];
    tabBarView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8f];
    [self.view addSubview:tabBarView];
    
    //开启照明按钮
    UIButton *lightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH - 100, 0, 100, tabBarH)];
    [lightBtn setImage:[UIImage imageNamed:@"flashON"] forState:UIControlStateNormal];
    [lightBtn addTarget:self action:@selector(openTorchButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [tabBarView addSubview:lightBtn];
}

- (void)setupCamera
{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //初始化相机设备
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        //初始化输入流
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
        
        //初始化输出流
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        //设置代理，主线程刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        //初始化链接对象
        _session = [[AVCaptureSession alloc] init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        
        if ([_session canAddInput:input]) {
            [_session addInput:input];
        }
        if ([_session canAddOutput:output]) {
            [_session addOutput:output];
        }
        
        //条码类型（二维码/条形码）
        output.metadataObjectTypes = [NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode, nil];
        
        //更新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
            _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
            _preview.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
            [self.view.layer insertSublayer:_preview atIndex:0];
//            CGRect rect = CGRectMake((kSCREEN_WIDTH - 250) / 2, (kSCREEN_HEIGHT - 250 - 72)/2, 250, 250);
//            output.rectOfInterest = [_preview metadataOutputRectOfInterestForRect:rect];
            [_session startRunning];
        });
    });
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
//    self.scanTop.constant -= 2;
//    if (self.scanTop.constant <= -170) {
//        self.scanTop.constant = 170;
//    }
    
    if (_distance++ > kSCREEN_WIDTH * 0.65) {
        _distance = 0;
    }
    _line.frame = CGRectMake(0, _distance, kSCREEN_WIDTH * 0.65, 2);
    
    
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

- (void)openTorchButtonTouched:(id)sender {
    
    UIButton *torchBtn = sender;
    BOOL isLightOpened = [self isLightOpened];
    
    if (isLightOpened) {
        [torchBtn setImage:[UIImage imageNamed:@"flashOFF"] forState:UIControlStateNormal];
        [torchBtn setBackgroundColor:[UIColor clearColor]];
    
    }else{
        [torchBtn setImage:[UIImage imageNamed:@"flashON"] forState:UIControlStateNormal];
        [torchBtn setBackgroundColor:[UIColor clearColor]];
    
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
        [ISVHUD showErrorWithStatus:@"请选择图片"];
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    NSError *error = nil;
    NSString *resultString = [ISVQRCodeTool stringFromQRCodeImage:image.CGImage error:error];
    
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

//绘制角图片
- (void)drawImageForImageView:(UIImageView *)imageView
{
    UIGraphicsBeginImageContext(imageView.bounds.size);
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条宽度
    CGContextSetLineWidth(context, 6.0f);
    //设置颜色
    CGContextSetStrokeColorWithColor(context, [[UIColor greenColor] CGColor]);
    //路径
    CGContextBeginPath(context);
    //设置起点坐标
    CGContextMoveToPoint(context, 0, imageView.bounds.size.height);
    //设置下一个点坐标
    CGContextAddLineToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, imageView.bounds.size.width, 0);
    //渲染，连接起点和下一个坐标点
    CGContextStrokePath(context);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

//绘制线图片
- (void)drawLineForImageView:(UIImageView *)imageView
{
    CGSize size = imageView.bounds.size;
    UIGraphicsBeginImageContext(size);
    
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //创建一个颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //设置开始颜色
    const CGFloat *startColorComponents = CGColorGetComponents([[UIColor greenColor] CGColor]);
    //设置结束颜色
    const CGFloat *endColorComponents = CGColorGetComponents([[UIColor whiteColor] CGColor]);
    //颜色分量的强度值数组
    CGFloat components[8] = {startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]
    };
    //渐变系数数组
    CGFloat locations[] = {0.0, 1.0};
    //创建渐变对象
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
    //绘制渐变
    CGContextDrawRadialGradient(context, gradient, CGPointMake(size.width * 0.5, size.height * 0.5), size.width * 0.25, CGPointMake(size.width * 0.5, size.height * 0.5), size.width * 0.5, kCGGradientDrawsBeforeStartLocation);
    //释放
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

@end
