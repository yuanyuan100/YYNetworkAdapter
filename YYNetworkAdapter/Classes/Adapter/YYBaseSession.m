//
//  YYBaseSession.m
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/3.
//

#import "YYBaseSession.h"


@implementation YYBaseSession

- (YYBaseSessionTask *)dataTaskWithRequest:(YYNetworkRequest *)request
                                   success:(YYNetworkSuccessBlock)success
                                   failure:(YYNetworkFailureBlock)failure {
    YYBaseSessionTask *task = [[YYBaseSessionTask alloc] init];
    
    task.success = success;
    task.failure = failure;
    task.request = request;
    task.originalPoolOfProtocol = self.poolOfProtocol.pool;
    task.poolOfProtocol = self.poolOfProtocol.pool.mutableCopy;
    [task start];
    
    [self.poolOfTask addTask:task];
    
    return task;
}

- (YYNetworkPoolOfProtocol *)poolOfProtocol {
    if (!_poolOfProtocol) {
        _poolOfProtocol = [[YYNetworkPoolOfProtocol alloc] init];
    }
    return _poolOfProtocol;
}

- (YYNetworkPoolOfSessionTask *)poolOfTask {
    if (!_poolOfTask) {
        _poolOfTask = [[YYNetworkPoolOfSessionTask alloc] init];
    }
    return _poolOfTask;
}

@end

@implementation YYBaseSession (Protocol)

- (YYBaseSessionTask *)dataTaskInProtocol:(YYNetworkProtocol *)protocol
                              withRequest:(YYNetworkRequest *)request
                                  success:(YYNetworkSuccessBlock)success
                                  failure:(YYNetworkFailureBlock)failure {
    YYBaseSessionTask *taskOfProtocol = (id)protocol.client;
    
    YYBaseSessionTask *task = [[YYBaseSessionTask alloc] init];
    task.pre = taskOfProtocol;
    taskOfProtocol.next = task;
    
    task.success = success;
    task.failure = failure;
    task.request = request;
    task.originalPoolOfProtocol = self.poolOfProtocol.pool;
    task.poolOfProtocol = self.poolOfProtocol.pool.mutableCopy;
    [task start];
    
    return task;
    
}

@end
