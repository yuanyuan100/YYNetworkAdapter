//
//  YYAFHTTPSessionManager.m
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/6.
//

#import "YYAFHTTPSessionManager.h"
#import "YYAFNetworkSession.h"
#import <AFNetworking/AFNetworking.h>

@implementation YYAFHTTPSessionManager

+ (instancetype)manager {
    static YYAFHTTPSessionManager *session;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[super allocWithZone:nil] init];
    });
    return  session;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self manager];
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return self;
}

- (AFHTTPSessionManager *)httpSessionManager {
    if (!_httpSessionManager) {
        if ([YYAFNetworkSession sharedSession].configuration) {
            _httpSessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil sessionConfiguration:[YYAFNetworkSession sharedSession].configuration];;
        } else {
            _httpSessionManager = [AFHTTPSessionManager manager];
        }
    }
    return _httpSessionManager;
}

@end
