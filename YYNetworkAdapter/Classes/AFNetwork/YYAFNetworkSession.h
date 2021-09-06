//
//  YYAFNetworkSession.h
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/6.
//

#import "YYBaseSession.h"
#import "YYAFNetworkSessionTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYAFNetworkSession : YYBaseSession

/// 伪单例。仅用来共享数据poolOfProtocol 和 poolOfTask
/// 也可以自己初始化一个YYAFNetworkSession。
@property (class, readonly) YYAFNetworkSession *sharedSession;
/// 伪单例
+ (YYAFNetworkSession *)sharedSessionWithConfiguration:(NSURLSessionConfiguration *)configuration;
/// 创建一个新的对象
+ (YYAFNetworkSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration;

/// 请求配置
@property (nonatomic, readonly, copy) NSURLSessionConfiguration *configuration;

/// 进度
- (YYAFNetworkSessionTask *)dataTaskWithRequest:(YYNetworkRequest *)request
                            uploadProgress:(nullable YYAFNetworkProgressBlock)uploadProgress
                                   success:(nullable YYNetworkSuccessBlock)success
                                   failure:(nullable YYNetworkFailureBlock)failure;
/// 上传
- (YYAFNetworkSessionTask *)uploadTaskWithRequest:(YYNetworkRequest *)request
                   constructingBodyWithBlock:(nullable YYAFNetworkUploadFormDataBlock)block
                              uploadProgress:(nullable YYAFNetworkProgressBlock)uploadProgress
                                     success:(nullable YYNetworkSuccessBlock)success
                                     failure:(nullable YYNetworkFailureBlock)failure;

/// 下载
- (YYAFNetworkSessionTask *)downloadTaskWithRequest:(YYNetworkRequest *)request
                              downloadProgress:(nullable YYAFNetworkProgressBlock)downloadProgress
                                   destination:(nullable YYAFNetworkDownloadDestinationBlock)block
                                     success:(nullable YYNetworkSuccessBlock)success
                                     failure:(nullable YYNetworkFailureBlock)failure;

@end

@interface YYAFNetworkSession (Protocol)

/// 进度
- (YYAFNetworkSessionTask *)dataTaskInProtocol:(YYNetworkProtocol *)protocol
                                   withRequest:(YYNetworkRequest *)request
                                uploadProgress:(nullable YYAFNetworkProgressBlock)uploadProgress
                                       success:(nullable YYNetworkSuccessBlock)success
                                       failure:(nullable YYNetworkFailureBlock)failure;
/// 上传
- (YYAFNetworkSessionTask *)uploadTaskInProtocol:(YYNetworkProtocol *)protocol
                                     withRequest:(YYNetworkRequest *)request
                       constructingBodyWithBlock:(nullable YYAFNetworkUploadFormDataBlock)block
                                  uploadProgress:(nullable YYAFNetworkProgressBlock)uploadProgress
                                         success:(nullable YYNetworkSuccessBlock)success
                                         failure:(nullable YYNetworkFailureBlock)failure;

/// 下载
- (YYAFNetworkSessionTask *)downloadTaskInProtocol:(YYNetworkProtocol *)protocol
                                       withRequest:(YYNetworkRequest *)request
                                  downloadProgress:(nullable YYAFNetworkProgressBlock)downloadProgress
                                       destination:(nullable YYAFNetworkDownloadDestinationBlock)block
                                           success:(nullable YYNetworkSuccessBlock)success
                                           failure:(nullable YYNetworkFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
