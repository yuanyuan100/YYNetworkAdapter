//
//  YYNetworkChain.h
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYNetworkChain : NSObject

/// 上一个
@property (nonatomic, weak, nullable) __kindof YYNetworkChain *pre;

/// 下一个
@property (nonatomic, strong, nullable) __kindof YYNetworkChain *next;

@end

NS_ASSUME_NONNULL_END
