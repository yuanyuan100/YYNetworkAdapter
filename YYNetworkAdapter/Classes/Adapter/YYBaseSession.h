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

@property (nonatomic, strong) YYNetworkPoolOfProtocol *poolOfProtocol;

@property (nonatomic, strong) YYNetworkPoolOfSessionTask *poolOfTask;


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

@end

NS_ASSUME_NONNULL_END
