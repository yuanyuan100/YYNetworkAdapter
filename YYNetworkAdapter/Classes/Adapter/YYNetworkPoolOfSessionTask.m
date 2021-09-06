//
//  YYNetworkPoolOfSessionTask.m
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/3.
//

#import "YYNetworkPoolOfSessionTask.h"
#import "YYBaseSessionTask.h"

@interface YYNetworkPoolOfSessionTask ()

@property (nonatomic, strong) NSMutableArray *taskPool;

@end

@implementation YYNetworkPoolOfSessionTask

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taskPool = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)addTask:(YYBaseSessionTask *)task {
    if ([task isMemberOfClass:YYBaseSessionTask.class]) {
        if ([self.taskPool containsObject:task] == NO) {
            [self.taskPool addObject:task];
            return YES;
        } else {
            NSLog(@"YYNetworkAdapter:[YYNetworkPoolOfSessionTask] %@ already exiting", task);
        }
    } else {
        NSAssert(NO, @"class is not YYBaseSessionTask  , is %@", NSStringFromClass(task.class));
        return NO;
    }
    return NO;
}

- (void)removeTask:(YYBaseSessionTask *)task {
    [self.taskPool removeObject:task];
}

@end
