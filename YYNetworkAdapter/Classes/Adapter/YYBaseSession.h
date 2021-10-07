//
//  YYBaseSession.h
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/3.
//

#import <Foundation/Foundation.h>
#import "YYNetworkPoolOfProtocol.h"
#import "YYNetworkPoolOfSessionTask.h"
#import "YYBaseSessionTask.h"
#import "YYNetworkRequest.h"
#import "YYNetworkProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYBaseSession : NSObject

/// 用来持有protocol类对象
/// 建议使用便利方法-[registerProtocol:] 和 -[unregisterProtocol:]
@property (nonatomic, strong, readonly) YYNetworkPoolOfProtocol *poolOfProtocol;

/// 用来持有task
@property (nonatomic, strong, readonly) YYNetworkPoolOfSessionTask *poolOfTask;

/// 在业务中发起的请求
/// @param request 请求对象
/// @param success 成功回调
/// @param failure 失败回调
- (YYBaseSessionTask *)dataTaskWithRequest:(YYNetworkRequest *)request
                                   success:(nullable YYNetworkSuccessBlock)success
                                   failure:(nullable YYNetworkFailureBlock)failure;

@end

@interface YYBaseSession (Protocol)

/// 在protocol中发起的请求
/// @param protocol 拦截器对象
/// @param request 请求对象
/// @param success 成功回调
/// @param failure 失败回调
- (YYBaseSessionTask *)dataTaskInProtocol:(YYNetworkProtocol *)protocol
                              withRequest:(YYNetworkRequest *)request
                                  success:(YYNetworkSuccessBlock)success
                                  failure:(YYNetworkFailureBlock)failure;

/// 注册protocol。protocol必须是YYNetworkProtocol的子类
- (BOOL)registerProtocol:(Class)protocol;

/// 移除protocol。protocol必须是YYNetworkProtocol的子类
- (void)unregisterProtocol:(Class)protocol;

@end

NS_ASSUME_NONNULL_END
