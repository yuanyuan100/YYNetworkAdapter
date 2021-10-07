//
//  YYAFNetworkSessionTask.h
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/6.
//

#import "YYBaseSessionTask.h"
@protocol AFMultipartFormData;

NS_ASSUME_NONNULL_BEGIN

/// 进度回调
typedef void(^YYAFNetworkProgressBlock)(NSProgress *);

/// 上传文件流
typedef void(^YYAFNetworkUploadFormDataBlock)(id<AFMultipartFormData>);

/// 指定下载路径
typedef NSURL * _Nonnull(^YYAFNetworkDownloadDestinationBlock)(NSURL *, NSURLResponse *);

@interface YYAFNetworkSessionTask : YYBaseSessionTask

/// 发送请求中的任务
@property (nonatomic, strong, nullable) __kindof NSURLSessionTask *sessionTask;

/// 上传进度回调
@property (nonatomic, copy, nullable) YYAFNetworkProgressBlock uploadProgress;

/// 下载进度回调
@property (nonatomic, copy, nullable) YYAFNetworkProgressBlock downloadProgress;

/// 上传文件流
@property (nonatomic, copy, nullable) YYAFNetworkUploadFormDataBlock constructingBody;

/// 下载指定路径
@property (nonatomic, copy, nullable) YYAFNetworkDownloadDestinationBlock destination;

@end

@interface YYAFNetworkSessionTask (Convenient)

/// 暂停。如果还在拦截其中执行，则直接取消请求
- (void)suspend;

/// 重启请求
- (void)resume;

/// 取消请求
- (void)cancel;

@end

NS_ASSUME_NONNULL_END
