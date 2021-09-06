//
//  YYNetworkPoolOfProtocol.m
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/3.
//

#import "YYNetworkPoolOfProtocol.h"

@interface YYNetworkPoolOfProtocol ()

@property (nonatomic, strong) NSMutableArray *mutablePool;

@end

@implementation YYNetworkPoolOfProtocol

- (instancetype)init
{
    self = [super init];
    if (self) {
        _mutablePool = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)addProtocol:(Class)cls {
    if ([cls isSubclassOfClass:YYNetworkProtocol.class]) {
        if ([self.mutablePool containsObject:cls] == NO) {
            [self.mutablePool addObject:cls];
            return YES;
        } else {
            NSLog(@"YYNetworkAdapter:[YYNetworkPoolOfProtocol] %@ already exiting", NSStringFromClass(cls));
        }
    } else {
        NSAssert(NO, @"YYNetworkAdapter:[YYNetworkPoolOfProtocol] class is not subclass of YYNetworkProtocol, is %@", NSStringFromClass(cls));
    }
    return NO;
}

- (void)removeProtocol:(Class)cls {
    [self.mutablePool removeObject:cls];
}

- (NSArray<Class> *)pool {
    return self.mutablePool.copy;
}

@end
