//
//  TaskManager.m
//  TXYUploadSDK
//
//  Created by Tencent on 15/2/1.
//  Copyright (c) 2015年 Qzone. All rights reserved.
//
#import "TaskManager.h"
#import "TXYBase.h"
#import "TXYUploadManager.h"
#import "HMHUD.h"

@interface TaskManager ()

@property (nonatomic, assign) BOOL suspended;

@property (nonatomic, strong)  NSMutableArray *taskModels;
@property (nonatomic, strong)  NSMutableArray  *uploadedVideoURLs;
@end

@implementation TaskManager

+ (TaskManager *)instance {
    static TaskManager *g_instance = nil;
    static  dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        g_instance = [[TaskManager alloc] init];
    });
    return g_instance;
}

- (instancetype)init
{
    if (self = [super init]){
        
        NSString *appId = @"10000940";
        self.uploadVideoManager = [[TXYUploadManager alloc] initWithCloudType:TXYCloudTypeForVideo persistenceId:@"videoCloudPersistenceId" appId:appId];
        
        _taskModels = [[NSMutableArray alloc] initWithCapacity:10];
        _uploadedVideoURLs = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)addTasks:(NSArray *)tasks
{
    
    if (tasks.count == 0) {
        return;
    }
    
    for (TXYUploadTask *task in tasks){
        
        if ([self addVideoTask:task successBlcok:nil failBlcok:nil]) {
            [_taskModels addObject:task];
        }
    }
}

#pragma mark - 上传视频
- (BOOL)addVideoTask:(TXYUploadTask *)task successBlcok:(void(^)(NSString *fileURL))successBlcok failBlcok:(void(^)(NSString *errMsg))failBlcok;
{
    __block TXYVideoTaskModel *videoTask = (TXYVideoTaskModel *)task;
    DECLARE_WEAK_SELF;
   BOOL bAdd =  [_uploadVideoManager upload:videoTask
    complete:^(TXYTaskRsp *resp, NSDictionary *context)
    {
        DECLARE_STRONG_SELF;
        TXYVideoUploadTaskRsp *videoResp = (TXYVideoUploadTaskRsp *)resp;
        //成功
        if (videoResp.retCode >= 0)
        {
            TXYURLInfo *urlInfo = [[TXYURLInfo alloc] init];
            urlInfo.thumbImage = videoTask.thumbImage;
            urlInfo.fileURL = videoResp.fileURL;
            
            urlInfo.fileId = videoResp.fileId;
            urlInfo.fileType = TXYFileTypeVideo;
            
            [strongSelf addVideoURL:urlInfo];
            
            //刷新界面
            [strongSelf.taskModels removeObject:videoTask];
            
            ! successBlcok ? : successBlcok(videoResp.fileURL);
            
            NSLog(@"videoResp.fileURL = %@", videoResp.fileURL);
        }
        else
        {
            videoTask.state = TXYUploadTaskStateFail;
            videoTask.errorDesc = [NSString stringWithFormat:@"错误码:%d,描述:%@",videoResp.retCode,videoResp.descMsg];
            
            [HMHUD showErrorWithStatus:videoTask.errorDesc];
            NSLog(@"videoTask.errorDesc = %@", videoTask.errorDesc);
            
            ! failBlcok ? : failBlcok(videoTask.errorDesc);
            
        }
    }
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    progress:^(int64_t totalSize, int64_t sendSize, NSDictionary *context)
    {
        
        videoTask.state = TXYUploadTaskStateSending;
        videoTask.totalLen = totalSize;
        videoTask.sendLen  = sendSize;

        if (sendSize > 0)
        {
            [HMHUD showProgress:(sendSize*1.0/(totalSize*1.0)) status:@"上传中..."];
        }
    }
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    stateChange:^(TXYUploadTaskState state, NSDictionary *context)
    {
        videoTask.state = state;
        NSLog(@"videoTask = %@", @(videoTask.state));

    }];
    
    return bAdd;
}



- (NSInteger)taskCount
{
    return [_taskModels count];
}

- (id<TaskUserInterface>)taskModelAtIndex:(NSInteger)index
{
    return [_taskModels objectAtIndex:index];
}


#pragma mark -- cancel handler
- (void)cancelTaskAtIndex:(int)index
{
    TXYUploadTask *task = [_taskModels objectAtIndex:index];
    
    if (!task) {
        return;
    }
    
    [self.uploadVideoManager cancel:task.taskId];
    
    [_taskModels removeObjectAtIndex:index];
}

- (void)cancelAllTasks
{
    [_taskModels removeAllObjects];
    [_uploadVideoManager clear];
}

- (void)suspendAllTasks
{
    [_uploadVideoManager pauseAll];
    self.suspended = YES;
}

- (void)resumeAllTasks
{
    [_uploadVideoManager resumeAll];
    self.suspended = NO;
}

- (BOOL)isSuspended
{
    return _suspended;
}

- (void)resendTaskAtIndex:(NSInteger)index
{
    TXYUploadTask* task = [self.taskModels objectAtIndex:index];
    [self.uploadVideoManager resume:task.taskId];
}

- (void)deleteTask:(NSInteger)index
{
    [_taskModels removeObjectAtIndex:index];
}

- (NSInteger)findTaskIndexWithTaskId:(int64_t)taskId
{
    NSInteger nIndex = -1;
    BOOL bFind = NO;
    
    for (TXYUploadTask* task in _taskModels)
    {
        nIndex++;
        if (task.taskId == taskId)
        {
            bFind = YES;
            break;
        }
    }
    
    if (!bFind)
    {
        nIndex = -1;
    }
    
    return nIndex;

}


- (void)clearAllURLInfo
{
    [_uploadedVideoURLs removeAllObjects];

    [self saveVideoURLInfo];
    [self saveFileURLInfo];
}
- (void)saveHistory
{
    [self saveVideoURLInfo];
}

#pragma mark -- 管理上传过的视频URL
- (NSInteger)videoURLCount
{
    return [_uploadedVideoURLs count];
}

- (TXYURLInfo *)videoURLAtIndex:(NSInteger)index
{
    return [_uploadedVideoURLs objectAtIndex:index];
}

- (BOOL)removeVideoURL:(NSInteger)index
{
    [_uploadedVideoURLs removeObjectAtIndex:index];
    [self saveVideoURLInfo];
    return YES;
}

- (void)addVideoURL:(TXYURLInfo *)urlInfo
{
    if (urlInfo) {
        [_uploadedVideoURLs addObject:urlInfo];
        [self saveVideoURLInfo];
    }
}


- (NSMutableArray *)uploadedVideoURLs
{
    return _uploadedVideoURLs;
}

#pragma mark -- 上传过图片和视频URL持久化
- (void)loadHistory
{
    NSArray* histroyURLs = [NSKeyedUnarchiver unarchiveObjectWithFile:[self urlInfoPath]];
    if (histroyURLs)
    {
//        [_uploadedPhotoURLs addObjectsFromArray:histroyURLs];
    }

    NSArray* histroyVideoURLs = [NSKeyedUnarchiver unarchiveObjectWithFile:[self videoURLPath]];
    if (histroyVideoURLs)
    {
        [_uploadedVideoURLs addObjectsFromArray:histroyVideoURLs];
    }
    
    NSArray* histroyFileURLs = [NSKeyedUnarchiver unarchiveObjectWithFile:[self fileURLPath]];
    if (histroyFileURLs)
    {
//        [_uploadedFileURLs addObjectsFromArray:histroyFileURLs];
    }

}



- (void)saveVideoURLInfo
{
    if ([_uploadedVideoURLs count] > 0)
    {
        @try
        {
            [NSKeyedArchiver archiveRootObject:_uploadedVideoURLs toFile:[self videoURLPath]];
        }
        @catch (NSException *exception)
        {
        }
    }
    else
    {
        
        @try
        {
            [[NSFileManager defaultManager] removeItemAtPath:[self videoURLPath] error: NULL];
        }
        @catch (NSException *exception)
        {
        }
    }
}
- (void)saveFileURLInfo
{
    
}
- (NSString *)fileURLPath
{
    return [[self DocPath] stringByAppendingFormat:@"/fileURLs.data"];
}

- (NSString *)videoURLPath
{
    return [[self DocPath] stringByAppendingFormat:@"/videoURLs.data"];
}

- (NSString *)urlInfoPath
{
    return [[self DocPath] stringByAppendingFormat:@"/urlInfo.data"];
}

-(NSString *)DocPath
{
    static NSString *documentsDirectory = nil;
    if (documentsDirectory) {
        return documentsDirectory;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

@end

#pragma mark

@implementation TXYPhotoTaskModel
@synthesize state = _state;
@synthesize thumbImage = _thumbImage;
@synthesize totalLen = _totalLen;
@synthesize sendLen = _sendLen;
@synthesize errorDesc = _errorDesc;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeInteger:self.state forKey:@"state"];
    [aCoder encodeObject:self.thumbImage forKey:@"thumbImage"];
    
    [aCoder encodeInt64:self.totalLen forKey:@"totalLen"];
    [aCoder encodeInt64:self.sendLen forKey:@"sendLen"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.thumbImage  = [aDecoder decodeObjectForKey:@"thumbImage"];
        self.state = [aDecoder decodeIntegerForKey:@"state"];
        
        self.totalLen = [aDecoder decodeInt64ForKey:@"totalLen"];
        self.sendLen  = [aDecoder decodeInt64ForKey:@"sendLen"];
    }
    return self;
}

- (NSString *)descText
{
    NSString *str = nil;
    if (self.state == TXYUploadTaskStateWait)
    {
        str = @"等待上传";
    }
    else if (self.state == TXYUploadTaskStateConnecting)
    {
        str = @"连接中";
    }
    else if (self.state == TXYUploadTaskStateSending){
        str = [NSString stringWithFormat:@"%.1fk/%.1fk", self.sendLen*1.0f/1024, self.totalLen*1.0f/1024];
    }
    else if (self.state == TXYUploadTaskStateFail) {
        str = self.errorDesc?:@"上传失败";
    }
    else if (self.state == TTXYUploadTaskStatePause) {
        str = @"暂停中";
    }
    
    return str;
}
-(NSString*)uploadInfo
{
    return nil;
}
@end

@implementation TXYVideoTaskModel
@synthesize state = _state;
@synthesize thumbImage = _thumbImage;
@synthesize totalLen = _totalLen;
@synthesize sendLen = _sendLen;
@synthesize errorDesc = _errorDesc;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeInteger:self.state forKey:@"state"];
    [aCoder encodeObject:self.thumbImage forKey:@"thumbImage"];
    
    [aCoder encodeInt64:self.totalLen forKey:@"totalLen"];
    [aCoder encodeInt64:self.sendLen forKey:@"sendLen"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.thumbImage  = [aDecoder decodeObjectForKey:@"thumbImage"];
        self.state = [aDecoder decodeIntegerForKey:@"state"];
        
        self.totalLen = [aDecoder decodeInt64ForKey:@"totalLen"];
        self.sendLen  = [aDecoder decodeInt64ForKey:@"sendLen"];
    }
    return self;
}

- (NSString *)descText
{
    NSString *str = nil;
    if (self.state == TXYUploadTaskStateWait)
    {
        str = @"等待上传";
    }
    else if (self.state == TXYUploadTaskStateConnecting)
    {
        str = @"连接中";
    }
    else if (self.state == TXYUploadTaskStateSending){
        str = [NSString stringWithFormat:@"%.1fk/%.1fk", self.sendLen*1.0f/1024, self.totalLen*1.0f/1024];
    }
    else if (self.state == TXYUploadTaskStateFail) {
        str = self.errorDesc?:@"上传失败";
    }
    else if (self.state == TTXYUploadTaskStatePause) {
        str = @"暂停中";
    }
    
    return str;
}
-(NSString*)uploadInfo
{
    return nil;
}
@end

@implementation TXYFileTaskModel
@synthesize state = _state;
@synthesize thumbImage = _thumbImage;
@synthesize totalLen = _totalLen;
@synthesize sendLen = _sendLen;
@synthesize errorDesc = _errorDesc;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeInteger:self.state forKey:@"state"];
    [aCoder encodeObject:self.thumbImage forKey:@"thumbImage"];
    
    [aCoder encodeInt64:self.totalLen forKey:@"totalLen"];
    [aCoder encodeInt64:self.sendLen forKey:@"sendLen"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.thumbImage  = [aDecoder decodeObjectForKey:@"thumbImage"];
        self.state = [aDecoder decodeIntegerForKey:@"state"];
        
        self.totalLen = [aDecoder decodeInt64ForKey:@"totalLen"];
        self.sendLen  = [aDecoder decodeInt64ForKey:@"sendLen"];
    }
    return self;
}

- (NSString *)descText
{
    NSString *str = nil;
    if (self.state == TXYUploadTaskStateWait)
    {
        str = @"等待上传";
    }
    else if (self.state == TXYUploadTaskStateConnecting)
    {
        str = @"连接中";
    }
    else if (self.state == TXYUploadTaskStateSending){
        str = [NSString stringWithFormat:@"%.1fk/%.1fk", self.sendLen*1.0f/1024, self.totalLen*1.0f/1024];
    }
    else if (self.state == TXYUploadTaskStateFail) {
        str = self.errorDesc?:@"上传失败";
    }
    else if (self.state == TTXYUploadTaskStatePause) {
        str = @"暂停中";
    }
    else if (self.state == TXYUploadTaskStateSuccess) {
        str = @"上传成功";
        if (self.accessUrl) {
            str = [str stringByAppendingString:@",accessUrl:"];
            str = [str stringByAppendingString:self.accessUrl];
        }
    }
    else if (self.state == TTXYUploadTaskStateCancel) {
        str = @"任务取消";
    }
    
    
    
    return str;
}
-(NSString*)uploadInfo
{
    NSString *result = [NSString stringWithFormat:@"UploadPath:%@,FilePath:%@",self.directory,self.filePath];
    return result;
}
@end


@implementation TXYURLInfo

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_thumbImage forKey:@"thumbImage"];
    [aCoder encodeObject:_fileURL forKey:@"imageURL"];
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.fileURL = [aDecoder decodeObjectForKey:@"fileURL"];
        self.thumbImage  = [aDecoder decodeObjectForKey:@"thumbImage"];
    }
    return self;
}

@end

