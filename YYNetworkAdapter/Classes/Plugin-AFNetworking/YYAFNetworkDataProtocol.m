//
//  YYAFNetworkDataProtocol.m
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/6.
//

#import "YYAFNetworkDataProtocol.h"
#import "YYAFHTTPSessionManager.h"
#import "YYAFNetworkProtocolClient.h"
#import "YYAFNetworkSessionTask.h"
#import "YYAFNetworkSession.h"
#import <YYNetworkAdapter/YYNerworkError.h>
#import <YYNetworkAdapter/YYNetworkRequest.h>
#import <AFNetworking/AFNetworking.h>

@interface YYAFNetworkDataProtocol ()
@property (nonatomic, weak, readonly) id<YYAFNetworkProtocolClient> client;
@end

@implementation YYAFNetworkDataProtocol
@dynamic client;

+ (BOOL)canInitWithRequest:(YYNetworkRequest *)request {
    if ([request.gatewayIdentifier isEqualToString:@"AFNetworking-data"]) {
        return YES;
    }
    return NO;
}

- (void)startLoading {
    
    AFHTTPSessionManager *session = [YYAFHTTPSessionManager manager].httpSessionManager;
    
    [self configForAFNetworking:session];

    YYAFNetworkSessionTask *task = (id)self.client;
    NSString *method = self.request.method.uppercaseString;
    // 发起请求
    __weak typeof(self) weakSelf = self;
    if ([method isEqualToString:@"GET"]) {
        task.sessionTask = [session GET:self.request.url parameters:self.request.parameters headers:self.request.header progress:^(NSProgress * _Nonnull downloadProgress) {
            [weakSelf.client protocol:weakSelf uploadProgress:downloadProgress];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf.client protocol:weakSelf didReceiveResponse:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.client protocol:weakSelf didFailWithError:error];
        }];
    } else if ([method isEqualToString:@"HEAD"]) {
        task.sessionTask = [session HEAD:self.request.url parameters:self.request.parameters headers:self.request.header success:^(NSURLSessionDataTask * _Nonnull task) {
            [weakSelf.client protocol:weakSelf didReceiveResponse:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.client protocol:weakSelf didFailWithError:error];
        }];
    } else if ([method isEqualToString:@"POST"]) {
        task.sessionTask = [session POST:self.request.url parameters:self.request.parameters headers:self.request.header progress:^(NSProgress * _Nonnull uploadProgress) {
            [weakSelf.client protocol:weakSelf uploadProgress:uploadProgress];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf.client protocol:weakSelf didReceiveResponse:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.client protocol:weakSelf didFailWithError:error];
        }];
    } else if ([method isEqualToString:@"PUT"]) {
        task.sessionTask = [session PUT:self.request.url parameters:self.request.parameters headers:self.request.header success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf.client protocol:weakSelf didReceiveResponse:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.client protocol:weakSelf didFailWithError:error];
        }];
    } else if ([method isEqualToString:@"PATCH"]) {
        task.sessionTask = [session PATCH:self.request.url parameters:self.request.parameters headers:self.request.header success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf.client protocol:weakSelf didReceiveResponse:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.client protocol:weakSelf didFailWithError:error];
        }];
    } else if ([method isEqualToString:@"DELETE"]) {
        task.sessionTask = [session DELETE:self.request.url parameters:self.request.parameters headers:self.request.header success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [weakSelf.client protocol:weakSelf didReceiveResponse:responseObject];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [weakSelf.client protocol:weakSelf didFailWithError:error];
        }];
    } else {
        NSError *error = [NSError errorWithDomain:[NSString stringWithFormat:@"%@ is a not exist method", method] code:YYNetworkErrorNotExistMethod userInfo:nil];
        [self.client protocol:self didFailWithError:error];
    }
}

- (void)configForAFNetworking:(AFHTTPSessionManager *)session {

    // 设置请求数据类型
    if (self.request.requestSerializerType == YYRequestSerializerTypeJSON) {
        session.requestSerializer = [AFJSONRequestSerializer serializer];
    } else if (self.request.requestSerializerType == YYRequestSerializerTypeHTTP) {
        session.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    session.requestSerializer.timeoutInterval = self.request.timeoutInterval;
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

@end
