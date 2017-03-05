//
//  TaskManager.h
//  TXYUploadSDK
//
//  Created by Tencent on 15/2/1.
//  Copyright (c) 2015年 Qzone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TXYBase.h"
#import "TXYUploadManager.h"

@class TaskBoxController;
@class TXYURLInfo;

#define DECLARE_WEAK_SELF __typeof(&*self) __weak weakSelf = self
#define DECLARE_STRONG_SELF __typeof(&*self) __strong strongSelf = weakSelf
@protocol TaskUserInterface;

@interface TaskManager : NSObject

/** 这里为了方便，直接在TaskBoxController创建的实例中把发件箱UI指定下 */
@property (nonatomic, weak) TaskBoxController *boxController;
@property (nonatomic, strong) TXYUploadManager *uploadFileManager; //文件云

@property (nonatomic, strong) TXYUploadManager *uploadImageManager; //图片云

@property (nonatomic, strong) TXYUploadManager *uploadVideoManager; //视频云
+ (TaskManager *)instance;
/*********************    管理上传图片和视频任务    ********************/

//添加任务
- (void)addTasks:(NSArray *)tasks;
- (BOOL)addVideoTask:(TXYUploadTask *)task successBlcok:(void(^)(NSString *fileURL))successBlcok failBlcok:(void(^)(NSString *errMsg))failBlcok;
- (void)saveHistory;
//当前任务数
- (NSInteger)taskCount;

- (id<TaskUserInterface>)taskModelAtIndex:(NSInteger)index;

- (void)cancelTaskAtIndex:(int)index;
- (void)cancelAllTasks;

- (void)suspendAllTasks;
- (void)resumeAllTasks;
- (BOOL)isSuspended;

- (void)resendTaskAtIndex:(NSInteger)index;

/*********************    管理上传过的视频URL    **********************/
- (NSInteger)videoURLCount;

- (TXYURLInfo *)videoURLAtIndex:(NSInteger)index;

- (BOOL)removeVideoURL:(NSInteger)index;

- (void)addVideoURL:(TXYURLInfo *)urlInfo;

- (NSMutableArray *)uploadedVideoURLs;


- (void)clearAllURLInfo;


@end


@protocol TaskUserInterface <NSObject>
//任务状态
@property (nonatomic, assign) TXYUploadTaskState state;
//缩略图
@property(nonatomic, strong) UIImage  *thumbImage;
//已发送
@property(nonatomic, assign) int64_t   sendLen;
//总大小
@property(nonatomic, assign) int64_t   totalLen;
//错误信息
@property (nonatomic,strong) NSString *errorDesc;

//状态描述信息
- (NSString *)descText;
- (NSString *)uploadInfo;

@end

@interface TXYFileTaskModel : TXYFileUploadTask <TaskUserInterface, NSCoding>
////上传路径
//@property (nonatomic,strong) NSString *uploadPath;
////本地路径
//@property (nonatomic,strong) NSString *filePath;

@property (nonatomic,strong) NSString *accessUrl;
@end

@interface TXYPhotoTaskModel : TXYPhotoUploadTask <TaskUserInterface, NSCoding>

@end


@interface TXYVideoTaskModel : TXYVideoUploadTask <TaskUserInterface, NSCoding>

@end



@interface TXYURLInfo : NSObject <NSCoding>
//缩略图
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) NSString *fileURL;

@property (nonatomic, strong) NSString *fileId;
@property (nonatomic, strong) NSString *bucket;
@property (nonatomic, assign) TXYFileType fileType;
@end
