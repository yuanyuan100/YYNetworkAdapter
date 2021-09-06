//
//  YYNetworkProtocol.m
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/3.
//

#import "YYNetworkProtocol.h"

@implementation YYNetworkProtocol

- (instancetype)initWithRequest:(YYNetworkRequest *)request client:(id<YYNetworkProtocolClient>)client {
    self = [self init];
    if (self) {
        _request = request;
        _client = client;
        [self startLoading];
    }
    return self;
}

#pragma mark -
+ (BOOL)canInitWithRequest:(id)request {
    return NO;
}

+ (void)setProperty:(id)value forKey:(NSString *)key inRequest:(YYNetworkRequest *)request {
    [request.propertyStoreForProtocol setObject:value forKey:key];
}

+ (id)propertyForKey:(NSString *)key inRequest:(YYNetworkRequest *)request {
    return [request.propertyStoreForProtocol objectForKey:key];
}

+ (void)removePropertyForKey:(NSString *)key inRequest:(YYNetworkRequest *)request {
    [request.propertyStoreForProtocol removeObjectForKey:key];
}

- (void)startLoading {
    NSLog(@"子类必须重写[startLoading]");
    [self doesNotRecognizeSelector:@selector(startLoading)];
}

- (void)stopLoadingWithError:(NSError *)error {
    [self.client protocol:self didFailWithError:error];
}

@end
