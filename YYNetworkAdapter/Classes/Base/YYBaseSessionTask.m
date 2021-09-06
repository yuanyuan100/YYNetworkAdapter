//
//  YYBaseSessionTask.m
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/6.
//

#import "YYBaseSessionTask.h"

@implementation YYBaseSessionTask

- (void)start {
    id<YYNetworkProtocolClient> client = self;
    while (self.poolOfProtocol.lastObject) {
        Class clz = self.poolOfProtocol.lastObject;
        if ([self.request.notAllowInterceptedSources containsObject:clz] == NO) {
            if ([clz respondsToSelector:@selector(canInitWithRequest:)]) {
                BOOL can = [clz canInitWithRequest:self.request];
                if (can) {
                    YYNetworkProtocol *protocolObject = [[clz alloc] initWithRequest:self.request client:client];
                    self.protocolObject = protocolObject;
                    break;
                }
            }
        }
        [self.poolOfProtocol removeLastObject];
    }
}

/// 通知task，任务成功完成
- (void)protocol:(YYNetworkProtocol *)protocol didReceiveResponse:(id)response {
    if (self.success) {
        self.success(response);
    }
    
    ///如果是任务链中最初的一个，则说明响应已回调到最上层。因此释放这条链
    if (self.pre == nil) {
        //[[LYURLSessionX sharedSession].taskPool removeTask:self];
    }
}

/// 通知task，任务失败
- (void)protocol:(YYNetworkProtocol *)protocol didFailWithError:(NSError *)error {
    if (self.failure) {
        self.failure(error);
    }
    
    ///如果是任务链中最初的一个，则说明响应已回调到最上层。因此释放这条链
    if (self.pre == nil) {
        //[[LYURLSessionX sharedSession].taskPool removeTask:self];
    }
}

@end
