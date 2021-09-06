//
//  YYNetworkRequest.m
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/3.
//

#import "YYNetworkRequest.h"

@interface YYNetworkRequest ()
/// 如果请求传递了url则直接使用，如果url为nil，则在拦截器中需要将scheme、host、port、path拼接起来
@property (nonatomic, copy, nullable) NSString *url;

/// For example, in the URL http://www.example.com/index.html, the scheme is http.
@property (nonatomic, copy, nullable) NSString *scheme;

/// in the URL http://www.example.com/index.html, the host is www.example.com.
@property (nonatomic, copy, nullable) NSString *host;

/// For example, in the URL http://www.example.com:8080/index.php, the port number is 8080.
@property (nonatomic, copy, nullable) NSNumber *port;

/// For example, in the URL http://www.example.com/index.html, the path is /index.html.
@property (nonatomic, copy, nullable) NSString *path;

/// 请求方式。默认nil
@property (nonatomic, copy, nullable) NSString *method;

/// 请求头
@property (nonatomic, copy, nullable) NSDictionary *header;

/// 请求参数
@property (nonatomic, copy, nullable) NSDictionary *parameters;

/// 设置超时时间
@property (nonatomic) NSTimeInterval timeoutInterval;

/// 是否允许蜂窝网络访问
@property (nonatomic) BOOL allowsCellularAccess;

/// 设置请求参数序列化类型
@property (nonatomic) YYRequestSerializerType requestSerializerType;

/// 设置响应数据序列化类型
@property (nonatomic) YYResponseSerializerType responseSerializerType;

/// 该请求不被以下拦截器拦截, class必须是YYNetworkProtocol的子类
@property (nonatomic, copy, nullable) NSArray<Class> *notAllowInterceptedSources;

/// 本地网关标识符
/// 决定该请求通过哪一网络框架发送。
/// 当前只配置了AFNetworking。
@property (nonatomic, copy) NSString *gatewayIdentifier;

/// 扩展对象，用于处理自定义事务
@property (nonatomic, strong, nullable) NSObject *extend;

/// 用来存储protocol中的标签
@property (nonatomic, strong) NSMutableDictionary *propertyStoreForProtocol;

@end

@implementation YYNetworkRequest

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareForInitData];
    }
    return self;
}

#pragma mark - NSCopying & NSMutableCopying
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    YYNetworkRequest *request = [[YYNetworkRequest alloc] init];
    request.url                        = self.url;
    request.scheme                     = self.scheme;
    request.host                       = self.host;
    request.port                       = self.port;
    request.path                       = self.path;
    request.method                     = self.method;
    request.header                     = self.header;
    request.parameters                 = self.parameters;
    request.allowsCellularAccess       = self.allowsCellularAccess;
    request.timeoutInterval            = self.timeoutInterval;
    request.requestSerializerType      = self.requestSerializerType;
    request.responseSerializerType     = self.responseSerializerType;
    request.notAllowInterceptedSources = self.notAllowInterceptedSources;
    request.gatewayIdentifier          = self.gatewayIdentifier;
    request.extend                     = self.extend;
    request.propertyStoreForProtocol   = self.propertyStoreForProtocol;
    return request;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    YYMutableNetworkRequest *request = [[YYMutableNetworkRequest alloc] init];
    request.url                        = self.url;
    request.scheme                     = self.scheme;
    request.host                       = self.host;
    request.port                       = self.port;
    request.path                       = self.path;
    request.method                     = self.method;
    request.header                     = self.header;
    request.parameters                 = self.parameters;
    request.allowsCellularAccess       = self.allowsCellularAccess;
    request.timeoutInterval            = self.timeoutInterval;
    request.requestSerializerType      = self.requestSerializerType;
    request.responseSerializerType     = self.responseSerializerType;
    request.notAllowInterceptedSources = self.notAllowInterceptedSources;
    request.gatewayIdentifier          = self.gatewayIdentifier;
    request.extend                     = self.extend;
    request.propertyStoreForProtocol   = self.propertyStoreForProtocol;
    return request;
}

+ (instancetype)request {
    return [[self alloc] init];
}

/// 配置默认参数
- (void)prepareForInitData {
    self.gatewayIdentifier = @"AFNetworking";
}

- (NSMutableDictionary *)propertyStoreForProtocol {
    if (!_propertyStoreForProtocol) {
        _propertyStoreForProtocol = [[NSMutableDictionary alloc] init];
    }
    return _propertyStoreForProtocol;
}

@end

@implementation YYMutableNetworkRequest
@dynamic url;
@dynamic scheme;
@dynamic host;
@dynamic port;
@dynamic path;
@dynamic method;
@dynamic header;
@dynamic parameters;
@dynamic allowsCellularAccess;
@dynamic timeoutInterval;
@dynamic requestSerializerType;
@dynamic responseSerializerType;
@dynamic notAllowInterceptedSources;
@dynamic gatewayIdentifier;
@dynamic extend;
@dynamic propertyStoreForProtocol;

@end
