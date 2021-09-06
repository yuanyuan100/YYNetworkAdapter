//
//  YYNetworkPoolOfProtocol.h
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYNetworkPoolOfProtocol : NSObject

@property (nonatomic, copy, nullable) NSArray<Class> *pool;

- (BOOL)addProtocol:(Class)cls;

- (void)removeProtocol:(Class)cls;

@end

NS_ASSUME_NONNULL_END
