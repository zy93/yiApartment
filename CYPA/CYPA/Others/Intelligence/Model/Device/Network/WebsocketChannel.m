//
//  WebsocketChannel.m
//  ruienDemo
//
//  Created by 张雨 on 2017/4/25.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import "WebsocketChannel.h"
#import "DeviceManager.h"

@implementation WebsocketChannel


+(WebsocketChannel *)shareWebsocketChannel
{
    static WebsocketChannel *mWebsocketChannel;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mWebsocketChannel = [[WebsocketChannel alloc] init];
    });
    return mWebsocketChannel;
}

//-(instancetype)init
//{
//    self = [super init];
//    if (self) {
//        
//    }
//    return self;
//}

-(void)openSocketWithURL:(NSString *)url
{
    mWebsocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:url]];
    mWebsocket.delegate = self;
    [mWebsocket open];
}

-(void)sendString:(NSString *)string
{
    NSError *error;
    [mWebsocket sendString:string error:&error];
    NSLog(@"****- websocket send message: %@", string);
}

#pragma mark - SRWebsocket delegate
//- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message
//{
//    NSLog(@"****- - websocket didReceive string:%@",message);
//    [[DeviceManager shareDeviceManager] receiveWebsocketWithString:message];
//}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string
{
    NSLog(@"****- - websocket didReceive string:%@",string);
    [[DeviceManager shareDeviceManager] receiveWebsocketWithString:string];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithData:(NSData *)data
{
    NSLog(@"****- - - websocket didReceive data:%@",data);
    [[DeviceManager shareDeviceManager] receiveWebsocketWithData:data];
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket
{
    NSLog(@"****- - - - websocket didOpen");

}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error
{
    NSLog(@"****- - - - websocket didFail error:%@",error);

}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean
{
    NSLog(@"****- - - - - websocket didClose Code:%ld",code);

}


@end
