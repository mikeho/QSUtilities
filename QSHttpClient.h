//
//  QSHttpClient.h
//  NextManga
//
//  Created by Mike Ho on 3/14/11.
//  Copyright 2011 Quasidea Development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QSHttpClient;

@protocol QSHttpClientDelegate
@optional
- (void)httpClientResponseReceived:(QSHttpClient *)objHttpClient;
- (void)httpClient:(QSHttpClient *)objHttpClient RequestProgressPercentage:(CGFloat)fltPercent;
- (void)httpClient:(QSHttpClient *)objHttpClient ResponseProgressPercentage:(CGFloat)fltPercent;
- (void)httpClient:(QSHttpClient *)objHttpClient ErrorReceived:(NSString *)strError;
@end


@interface QSHttpClient : NSObject {
@private
	NSString * _strUrl;
	NSString * _strHttpMethod;
	NSInteger _intTimeoutInterval;
	
	NSInteger _intHttpStatusCode;
	NSMutableData * _objResponseData;
	
	NSInteger _intRequestDataSize;
	NSInteger _intResponseDataSize;

	NSInteger _intTag;
	NSInteger _intArbitraryIdentifier;
	id <QSHttpClientDelegate> _objDelegate;
}

@property (nonatomic, retain, getter=url, setter=setUrl:) NSString * _strUrl;
@property (nonatomic, retain, getter=httpMethod, setter=setHttpMethod:) NSString * _strHttpMethod;
@property (nonatomic, assign, getter=timeoutInterval, setter=setTimeoutInterval:) NSInteger _intTimeoutInterval;

@property (nonatomic, assign, getter=httpStatusCode) NSInteger _intHttpStatusCode;
@property (nonatomic, retain, getter=responseData) NSData * _objResponseData;

@property (nonatomic, assign, getter=tag, setter=setTag:) NSInteger _intTag;
@property (nonatomic, assign, getter=arbitraryIdentifier, setter=setArbitraryIdentifier:) NSInteger _intArbitraryIdentifier;
@property (nonatomic, assign /* weak ref */, getter=delegate, setter=setDelegate:) id <QSHttpClientDelegate> _objDelegate;

- (QSHttpClient *)initWithUrl:(NSString *)strUrl HttpMethod:(NSString *)strHttpMethod;

- (void)cleanupFromPreviousRequests;

- (void)sendString:(NSString *)strRequest;
- (void)sendFile:(NSString *)strFilePath;

- (NSString *)getResponseAsString;
- (NSData *)getResponseAsRawData;

@end
