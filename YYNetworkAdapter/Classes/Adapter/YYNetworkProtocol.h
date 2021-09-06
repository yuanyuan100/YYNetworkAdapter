//
//  YYNetworkProtocol.h
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYNetworkProtocol : NSObject

- (instancetype)initWithRequest:(YYNetworkRequest *)request client:(id<YYNetworkProtocolClient>)client;
/// 请求信息
@property (nonatomic, strong, readonly) YYNetworkRequest *request;
/// 相当于数据转发者
@property (nonatomic, weak, readonly) id<YYNetworkProtocolClient> client;

/// 判断是否拦截
+ (BOOL)canInitWithRequest:(YYNetworkRequest *)request;

/// 取出标签
+ (nullable id)propertyForKey:(NSString *)key inRequest:(YYNetworkRequest *)request;
/// 增加标签, 用作判断是否拦截
+ (void)setProperty:(id)value forKey:(NSString *)key inRequest:(YYNetworkRequest *)request;
/// 移除标签
+ (void)removePropertyForKey:(NSString *)key inRequest:(YYNetworkRequest *)request;

/// 如果阻止请求后请在该方法中重新发起请求, 此方法必须重写
- (void)startLoading;

/// 外部(业务)发起取消请求。可选重写。重写后需要调用 [protocol: didFailWithError:]
- (void)stopLoadingWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
