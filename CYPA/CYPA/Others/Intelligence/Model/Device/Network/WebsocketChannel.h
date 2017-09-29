//
//  WebsocketChannel.h
//  ruienDemo
//
//  Created by 张雨 on 2017/4/25.
//  Copyright © 2017年 张雨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"
#import "DeviceManager.h"

@interface WebsocketChannel : NSObject <SRWebSocketDelegate>
{
    SRWebSocket *mWebsocket;
}


+(WebsocketChannel *)shareWebsocketChannel;

-(void)openSocketWithURL:(NSString *)url;


-(void)sendString:(NSString *)string;



@end
