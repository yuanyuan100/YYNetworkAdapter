//
//  YYAFNetworkSessionTask.m
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/6.
//

#import "YYAFNetworkSessionTask.h"
#import "YYAFNetworkProtocolClient.h"

@interface YYAFNetworkSessionTask () <YYAFNetworkProtocolClient>

@end

@implementation YYAFNetworkSessionTask

- (void)setSessionTask:(__kindof NSURLSessionTask * _Nullable)sessionTask {
    _sessionTask = sessionTask;
    
    YYAFNetworkSessionTask *pre = self.pre;
    pre.sessionTask = sessionTask;
}

/// 上传进度回调
- (void)protocol:(YYNetworkProtocol *)protocol uploadProgress:(NSProgress *)progress {
    if (self.uploadProgress) {
        self.uploadProgress(progress);
    } else {
        // 如果没实现，则寻找上一个task的protocol，主动调用, 防止中间有的自定义protocol没有调用全量参数的接口导致回调丢失
        YYAFNetworkSessionTask *pre = self.pre;
        [pre protocol:pre.protocolObject uploadProgress:progress];
    }
}

/// 下载进度回调
- (void)protocol:(YYNetworkProtocol *)protocol downloadProgress:(NSProgress *)progress {
    if (self.downloadProgress) {
        self.downloadProgress(progress);
    } else {
        // 如果没实现，则寻找上一个task的protocol，主动调用, 防止中间有的自定义protocol没有调用全量参数的接口导致回调丢失
        YYAFNetworkSessionTask *pre = self.pre;
        [pre protocol:pre.protocolObject downloadProgress:progress];
    }
}

/// 上传文件
- (void)protocol:(YYNetworkProtocol *)protocol constructingBody:(id<AFMultipartFormData>)formData {
    if (self.constructingBody) {
        self.constructingBody(formData);
    } else {
        // 如果没实现，则寻找上一个task的protocol，主动调用, 防止中间有的自定义protocol没有调用全量参数的接口导致回调丢失
        YYAFNetworkSessionTask *pre = self.pre;
        [pre protocol:pre.protocolObject constructingBody:formData];
    }
}

/// 下载文件指定路径
- (NSURL *)protocol:(YYNetworkProtocol *)protocol targetPath:(NSURL *)targetPath response:(NSURLResponse *)response {
    if (self.destination) {
        return self.destination(targetPath, response);
    } else {
        // 如果没实现，则寻找上一个task的protocol，主动调用, 防止中间有的自定义protocol没有调用全量参数的接口导致回调丢失
        YYAFNetworkSessionTask *pre = self.pre;
        NSURL *url = [pre protocol:pre.protocolObject targetPath:targetPath response:response];
        if (url) {
            return url;
        }
    }
    ///默认返回一个本地的 NSURL
    return [self defaultPathWithFileName:response.suggestedFilename];
}

- (NSURL *)defaultPathWithFileName:(NSString *)fileName {
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fullpath = [caches stringByAppendingPathComponent:fileName?:[NSUUID UUID].UUIDString];
    NSURL *filePathUrl = [NSURL fileURLWithPath:fullpath];
    return filePathUrl;
}

@end

@implementation YYAFNetworkSessionTask (Convenient)

- (void)suspend {
    if (self.sessionTask) {
        [self.sessionTask suspend];
    } else {
        [self cancel];
    }
}

- (void)resume {
    if (self.sessionTask) {
        [self.sessionTask resume];
    } else {
        [self start];
    }
}

- (void)cancel {
    if (self.sessionTask) {
        [self.sessionTask cancel];
        return;
    }
    
    YYAFNetworkSessionTask *task = self;
    while (task.next) {
        task = task.next;
    }
    NSError *error = [NSError errorWithDomain:@"NSURLErrorCancelled" code:NSURLErrorCancelled userInfo:nil];
    [task.protocolObject stopLoadingWithError:error];
}

@end
