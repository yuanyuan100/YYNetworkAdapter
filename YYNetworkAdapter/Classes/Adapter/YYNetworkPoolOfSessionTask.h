//
//  YYNetworkPoolOfSessionTask.h
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/3.
//

#import <Foundation/Foundation.h>
@class YYBaseSessionTask;

NS_ASSUME_NONNULL_BEGIN

@interface YYNetworkPoolOfSessionTask : NSObject

- (BOOL)addTask:(__kindof YYBaseSessionTask *)task;

- (void)removeTask:(__kindof YYBaseSessionTask *)task;

@end

NS_ASSUME_NONNULL_END
