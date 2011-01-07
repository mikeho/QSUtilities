//
//  Strings.h
//  iVQ
//
//  Created by Mike Ho on 10/8/10.
//  Copyright 2010 Quasidea Development, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Strings : NSObject {

}
+ (NSString *)implodeArray:(NSArray *)strArray WithGlue:(NSString *)strGlue;
+ (NSString *)implodeObjectArray:(NSArray *)objArray WithSelector:(SEL)selSelector Glue:(NSString *)strGlue;
+ (NSString *)trimString:(NSString *)strString;
+ (NSString *)escapeForXml:(NSString *)strString;
+ (NSString *)xmlDateStringForDate:(NSDate *)dttDate;
+ (NSString *)htmlEntities:(NSString *)strString;

@end
