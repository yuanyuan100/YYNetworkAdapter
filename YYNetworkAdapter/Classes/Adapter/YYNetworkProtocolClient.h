//
//  YYNetworkProtocolClient.h
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/3.
//

#import <Foundation/Foundation.h>
@class YYNetworkProtocol;

NS_ASSUME_NONNULL_BEGIN

@protocol YYNetworkProtocolClient <NSObject>

/// 通知task，任务成功完成
- (void)protocol:(YYNetworkProtocol *)protocol didReceiveResponse:(nullable id)response;

/// 通知task，任务失败
- (void)protocol:(YYNetworkProtocol *)protocol didFailWithError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
