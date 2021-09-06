//
//  YYBaseSessionTask.h
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/6.
//

#import "YYNetworkChain.h"

NS_ASSUME_NONNULL_BEGIN

/// 成功回调
typedef void(^YYNetworkSuccessBlock)(id);

/// 失败回调
typedef void(^YYNetworkFailureBlock)(NSError *);

@interface YYBaseSessionTask : YYNetworkChain <YYNetworkProtocolClient>

/// YYNetworkAdapter中的请求
@property (nonatomic, strong) __kindof YYNetworkRequest *request;

/// 本条链上第一个task需要遍历的protocol pool
@property (nonatomic, copy) NSArray<Class> *originalPoolOfProtocol;

/// 当前task下需要遍历的protocol pool
@property (nonatomic, strong) NSMutableArray<Class> *poolOfProtocol;

/// 该task下持有的protocol对象
@property (nonatomic, strong) __kindof YYNetworkProtocol *protocolObject;

/// 成功回调
@property (nonatomic, copy, nullable) YYNetworkSuccessBlock success;

/// 失败回调
@property (nonatomic, copy, nullable) YYNetworkFailureBlock failure;

/// 开始
- (void)start;

@end

NS_ASSUME_NONNULL_END
