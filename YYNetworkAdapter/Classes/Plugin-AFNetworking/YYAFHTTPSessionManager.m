//
//  YYAFHTTPSessionManager.m
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/6.
//

#import "YYAFHTTPSessionManager.h"
#import "YYAFNetworkSession.h"

@implementation YYAFHTTPSessionManager

+ (instancetype)manager {
    static YYAFHTTPSessionManager *_session;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _session = [[super allocWithZone:nil] init];
    });
    return  _session;
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
