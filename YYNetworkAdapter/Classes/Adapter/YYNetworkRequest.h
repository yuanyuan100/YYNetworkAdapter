//
//  YYNetworkRequest.h
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/3.
//

#import <Foundation/Foundation.h>
@class LYMutableNetworkRequest;

NS_ASSUME_NONNULL_BEGIN

/// 设置请求序列化的类型
typedef NS_ENUM(NSInteger, YYRequestSerializerType) {
    /// NSData
    YYRequestSerializerTypeHTTP = 0,
    /// JSON
    YYRequestSerializerTypeJSON,
};

/// 设置响应序列化的类型
typedef NS_ENUM(NSInteger, YYResponseSerializerType) {
    /// NSData
    YYResponseSerializerTypeHTTP,
    /// JSON
    YYResponseSerializerTypeJSON,
    /// NSXMLParser
    YYResponseSerializerTypeXMLParser,
};

extern NSString * const YYNetworkRequestAFNetworking_data;
extern NSString * const YYNetworkRequestAFNetworking_upload;
extern NSString * const YYNetworkRequestAFNetworking_dowload;

@interface YYNetworkRequest : NSObject <NSCopying, NSMutableCopying>

// 便利的初始化方法
+ (instancetype)request;

/// 如果请求传递了url则直接使用，如果url为nil，则在拦截器中需要将scheme、host、port、path拼接起来
@property (nonatomic, copy, readonly, nullable) NSString *url;

/// For example, in the URL http://www.example.com/index.html, the scheme is http.
@property (nonatomic, copy, readonly, nullable) NSString *scheme;

/// in the URL http://www.example.com/index.html, the host is www.example.com.
@property (nonatomic, copy, readonly, nullable) NSString *host;

/// For example, in the URL http://www.example.com:8080/index.php, the port number is 8080.
@property (nonatomic, copy, readonly, nullable) NSNumber *port;

/// For example, in the URL http://www.example.com/index.html, the path is /index.html.
@property (nonatomic, copy, readonly, nullable) NSString *path;

/// 请求方式。默认POST。不区分大小写
@property (nonatomic, copy, readonly, nullable) NSString *method;

/// 请求头
@property (nonatomic, copy, readonly, nullable) NSDictionary *header;

/// 请求参数
@property (nonatomic, copy, readonly, nullable) NSDictionary *parameters;

/// 设置超时时间
@property (nonatomic, readonly) NSTimeInterval timeoutInterval;

/// 是否允许蜂窝网络访问
@property (nonatomic, readonly) BOOL allowsCellularAccess;

/// 设置请求参数序列化类型
@property (nonatomic, readonly) YYRequestSerializerType requestSerializerType;

/// 设置响应数据序列化类型
@property (nonatomic, readonly) YYResponseSerializerType responseSerializerType;

/// 设置接受数据类型
@property (nonatomic, copy, readonly, nullable) NSSet <NSString *> *acceptableContentTypes;

/// 该请求不被以下拦截器拦截, class必须是YYNetworkProtocol的子类
@property (nonatomic, copy, readonly, nullable) NSArray<Class> *notAllowInterceptedSources;

/// 本地网关标识符
/// 决定该请求通过哪一网络框架发送。
/// 当前只配置了AFNetworking中的三种。
/// AFNetworking-data
/// AFNetworking-upload
/// AFNetworking-dowload
@property (nonatomic, copy, readonly) NSString *gatewayIdentifier;

/// 扩展对象，用于处理自定义事务
@property (nonatomic, strong, readonly, nullable) NSObject *extend;

/// 用来存储protocol中的标签
@property (nonatomic, strong, readonly) NSMutableDictionary *propertyStoreForProtocol;

@end

// 可变请求对象
@interface YYMutableNetworkRequest : YYNetworkRequest
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

/// 设置接受数据类型
@property (nonatomic, copy, readonly, nullable) NSSet <NSString *> *acceptableContentTypes;

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

NS_ASSUME_NONNULL_END
