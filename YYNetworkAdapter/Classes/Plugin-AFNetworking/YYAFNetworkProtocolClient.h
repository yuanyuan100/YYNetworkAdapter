//
//  YYAFNetworkProtocolClient.h
//  YYNetworkAdapter
//
//  Created by YuanYuan Peng on 2021/9/6.
//

#import <Foundation/Foundation.h>
@protocol AFMultipartFormData;

NS_ASSUME_NONNULL_BEGIN

@protocol YYAFNetworkProtocolClient <YYNetworkProtocolClient>



/// 上传进度回调
- (void)protocol:(YYNetworkProtocol *)protocol uploadProgress:(NSProgress *)progress;

/// 下载进度回调
- (void)protocol:(YYNetworkProtocol *)protocol downloadProgress:(NSProgress *)progress;

/// 上传文件
- (void)protocol:(YYNetworkProtocol *)protocol constructingBody:(id<AFMultipartFormData>)formData;

/// 下载文件指定路径
- (NSURL *)protocol:(YYNetworkProtocol *)protocol targetPath:(NSURL *)targetPath response:(NSURLResponse *)response;

@end

NS_ASSUME_NONNULL_END
