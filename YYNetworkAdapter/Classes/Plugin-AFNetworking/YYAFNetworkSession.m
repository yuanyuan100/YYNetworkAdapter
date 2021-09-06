//
//  YYAFNetworkSession.m
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/6.
//

#import "YYAFNetworkSession.h"

@interface YYAFNetworkSession ()
@property (nonatomic, copy) NSURLSessionConfiguration *configuration;
@end

@implementation YYAFNetworkSession

+ (instancetype)sharedSession {
    static YYAFNetworkSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[self alloc] init];
    });
    return session;
}

+ (YYAFNetworkSession *)sharedSessionWithConfiguration:(NSURLSessionConfiguration *)configuration {
    YYAFNetworkSession *session = [self sharedSession];
    session.configuration = configuration;
    return session;
}

+ (YYAFNetworkSession *)sessionWithConfiguration:(NSURLSessionConfiguration *)configuration {
    YYAFNetworkSession *session = [[self alloc] init];
    session.configuration = configuration;
    return session;
}

- (AFSecurityPolicy *)securityPolicy {
    if (!_securityPolicy) {
        _securityPolicy = [AFSecurityPolicy defaultPolicy];
    }
    return _securityPolicy;
}

- (YYAFNetworkSessionTask *)dataTaskWithRequest:(YYNetworkRequest *)request
                                   success:(YYNetworkSuccessBlock)success
                                   failure:(YYNetworkFailureBlock)failure {
    YYAFNetworkSessionTask *task = [[YYAFNetworkSessionTask alloc] init];
    
    task.success = success;
    task.failure = failure;
    task.request = request;
    task.originalPoolOfProtocol = self.poolOfProtocol.pool;
    task.poolOfProtocol = self.poolOfProtocol.pool.mutableCopy;
    [task start];
    
    [self.poolOfTask addTask:task];
    
    return task;
}

- (YYAFNetworkSessionTask *)dataTaskWithRequest:(YYNetworkRequest *)request
                                 uploadProgress:(YYAFNetworkProgressBlock)uploadProgress
                                        success:(YYNetworkSuccessBlock)success
                                        failure:(YYNetworkFailureBlock)failure {
    YYAFNetworkSessionTask *task = [[YYAFNetworkSessionTask alloc] init];
    
    task.uploadProgress = uploadProgress;
    task.success = success;
    task.failure = failure;
    task.request = request;
    task.originalPoolOfProtocol = self.poolOfProtocol.pool;
    task.poolOfProtocol = self.poolOfProtocol.pool.mutableCopy;
    [task start];
    
    [self.poolOfTask addTask:task];
    
    return task;
    
}

- (YYAFNetworkSessionTask *)uploadTaskWithRequest:(YYNetworkRequest *)request
                        constructingBodyWithBlock:(YYAFNetworkUploadFormDataBlock)block
                                   uploadProgress:(YYAFNetworkProgressBlock)uploadProgress
                                          success:(YYNetworkSuccessBlock)success
                                          failure:(YYNetworkFailureBlock)failure {
    YYAFNetworkSessionTask *task = [[YYAFNetworkSessionTask alloc] init];
    
    task.constructingBody = block;
    task.uploadProgress = uploadProgress;
    task.success = success;
    task.failure = failure;
    task.request = request;
    task.originalPoolOfProtocol = self.poolOfProtocol.pool;
    task.poolOfProtocol = self.poolOfProtocol.pool.mutableCopy;
    [task start];
    
    [self.poolOfTask addTask:task];
    
    return task;
    
}

- (YYAFNetworkSessionTask *)downloadTaskWithRequest:(YYNetworkRequest *)request
                                   downloadProgress:(YYAFNetworkProgressBlock)downloadProgress
                                        destination:(YYAFNetworkDownloadDestinationBlock)block
                                            success:(YYNetworkSuccessBlock)success
                                            failure:(YYNetworkFailureBlock)failure {
    YYAFNetworkSessionTask *task = [[YYAFNetworkSessionTask alloc] init];
    
    task.downloadProgress = downloadProgress;
    task.destination = block;
    task.success = success;
    task.failure = failure;
    task.request = request;
    task.originalPoolOfProtocol = self.poolOfProtocol.pool;
    task.poolOfProtocol = self.poolOfProtocol.pool.mutableCopy;
    [task start];
    
    [self.poolOfTask addTask:task];
    
    return task;
    
}

@end

@implementation YYAFNetworkSession (Protocol)

- (YYAFNetworkSessionTask *)dataTaskInProtocol:(YYNetworkProtocol *)protocol
                              withRequest:(YYNetworkRequest *)request
                                  success:(YYNetworkSuccessBlock)success
                                  failure:(YYNetworkFailureBlock)failure {
    YYAFNetworkSessionTask *taskOfProtocol = (id)protocol.client;
    
    YYAFNetworkSessionTask *task = [[YYAFNetworkSessionTask alloc] init];
    task.pre = taskOfProtocol;
    taskOfProtocol.next = task;
    
    task.success = success;
    task.failure = failure;
    task.request = request;
    task.originalPoolOfProtocol = self.poolOfProtocol.pool;
    task.poolOfProtocol = self.poolOfProtocol.pool.mutableCopy;
    [task start];
    
    return task;
    
}



- (YYAFNetworkSessionTask *)dataTaskInProtocol:(YYNetworkProtocol *)protocol
                                   withRequest:(YYNetworkRequest *)request
                                uploadProgress:(YYAFNetworkProgressBlock)uploadProgress
                                       success:(YYNetworkSuccessBlock)success
                                       failure:(YYNetworkFailureBlock)failure {
    YYAFNetworkSessionTask *taskOfProtocol = (id)protocol.client;
    
    YYAFNetworkSessionTask *task = [[YYAFNetworkSessionTask alloc] init];
    task.pre = taskOfProtocol;
    taskOfProtocol.next = task;
    
    task.uploadProgress = uploadProgress;
    task.success = success;
    task.failure = failure;
    task.request = request;
    task.originalPoolOfProtocol = self.poolOfProtocol.pool;
    task.poolOfProtocol = self.poolOfProtocol.pool.mutableCopy;
    [task start];
    
    return task;
}

- (YYAFNetworkSessionTask *)uploadTaskInProtocol:(YYNetworkProtocol *)protocol
                                     withRequest:(YYNetworkRequest *)request
                       constructingBodyWithBlock:(YYAFNetworkUploadFormDataBlock)block
                                  uploadProgress:(YYAFNetworkProgressBlock)uploadProgress
                                         success:(YYNetworkSuccessBlock)success
                                         failure:(YYNetworkFailureBlock)failure {
    YYAFNetworkSessionTask *taskOfProtocol = (id)protocol.client;
    
    YYAFNetworkSessionTask *task = [[YYAFNetworkSessionTask alloc] init];
    task.pre = taskOfProtocol;
    taskOfProtocol.next = task;
    
    task.constructingBody = block;
    task.uploadProgress = uploadProgress;
    task.success = success;
    task.failure = failure;
    task.request = request;
    task.originalPoolOfProtocol = self.poolOfProtocol.pool;
    task.poolOfProtocol = self.poolOfProtocol.pool.mutableCopy;
    [task start];
    
    return task;
    
}

- (YYAFNetworkSessionTask *)downloadTaskInProtocol:(YYNetworkProtocol *)protocol
                                       withRequest:(YYNetworkRequest *)request
                                  downloadProgress:(YYAFNetworkProgressBlock)downloadProgress
                                       destination:(YYAFNetworkDownloadDestinationBlock)block
                                           success:(YYNetworkSuccessBlock)success
                                           failure:(YYNetworkFailureBlock)failure {
    YYAFNetworkSessionTask *taskOfProtocol = (id)protocol.client;
    
    YYAFNetworkSessionTask *task = [[YYAFNetworkSessionTask alloc] init];
    task.pre = taskOfProtocol;
    taskOfProtocol.next = task;
    
    task.destination = block;
    task.downloadProgress = downloadProgress;
    task.success = success;
    task.failure = failure;
    task.request = request;
    task.originalPoolOfProtocol = self.poolOfProtocol.pool;
    task.poolOfProtocol = self.poolOfProtocol.pool.mutableCopy;
    [task start];
    
    return task;
    
}

@end
