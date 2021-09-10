//
//  YYAFHTTPSessionManager.h
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/6.
//

#import <Foundation/Foundation.h>
@class AFHTTPSessionManager;

NS_ASSUME_NONNULL_BEGIN

@interface YYAFHTTPSessionManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;

+ (instancetype)manager;

@end

NS_ASSUME_NONNULL_END
