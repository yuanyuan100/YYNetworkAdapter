//
//  YYAFNetworkDownloadProtocol.m
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/10/8.
//

#import "YYAFNetworkDownloadProtocol.h"
#import <YYNetworkAdapter/YYNetworkRequest.h>
#import <AFNetworking/AFNetworking.h>
#import "YYAFHTTPSessionManager.h"

@interface YYAFNetworkDownloadProtocol ()

@property (nonatomic, weak, readonly) id<YYAFNetworkProtocolClient> client;

@end

@implementation YYAFNetworkDownloadProtocol
@dynamic client;

+ (BOOL)canInitWithRequest:(YYNetworkRequest *)request {
    if ([request.gatewayIdentifier isEqualToString:YYNetworkRequestAFNetworking_upload]) {
        return YES;
    }
    return NO;
}

- (void)startLoading {
    AFHTTPSessionManager *session = [YYAFHTTPSessionManager manager].httpSessionManager;
    [self configForAFNetworking:session];
    
    YYAFNetworkSessionTask *task = (id)self.client;
    __weak typeof(self) weakSelf = self;
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.request.url]];
    task.sessionTask = [[session downloadTaskWithRequest:req progress:^(NSProgress * _Nonnull downloadProgress) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.client protocol:strongSelf downloadProgress:downloadProgress];
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.client protocol:strongSelf targetPath:targetPath response:response];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (error) {
            [strongSelf.client protocol:strongSelf didReceiveResponse:@{@"filePath":filePath.absoluteString?:@""}];
        } else {
            [strongSelf.client protocol:strongSelf didFailWithError:error];
        }
    }];
}

- (void)configForAFNetworking:(AFHTTPSessionManager *)session {

    // 设置请求数据类型
    if (self.request.requestSerializerType == YYRequestSerializerTypeJSON) {
        session.requestSerializer = [AFJSONRequestSerializer serializer];
    } else if (self.request.requestSerializerType == YYRequestSerializerTypeHTTP) {
        session.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    // session.requestSerializer.timeoutInterval = self.request.timeoutInterval;
    session.requestSerializer.allowsCellularAccess = self.request.allowsCellularAccess;

    /// 设置响应数据类型
    if (self.request.responseSerializerType == YYResponseSerializerTypeJSON) {
        session.responseSerializer = [AFJSONResponseSerializer serializer];
    } else if (self.request.responseSerializerType == YYResponseSerializerTypeHTTP) {
        session.responseSerializer = [AFHTTPResponseSerializer serializer];
    } else if (self.request.responseSerializerType == YYResponseSerializerTypeXMLParser) {
        session.responseSerializer = [AFXMLParserResponseSerializer serializer];
    }
    
    /// 设置响应接受的数据类型
    if (self.request.acceptableContentTypes) {
        session.responseSerializer.acceptableContentTypes = self.request.acceptableContentTypes;
    }

    /// 安全连接设置
    if ([YYAFNetworkSession sharedSession].securityPolicy) {
        session.securityPolicy = [YYAFNetworkSession sharedSession].securityPolicy;
    }
    
}
