//
//  Strings.m
//  iVQ
//
//  Created by Mike Ho on 10/8/10.
//  Copyright 2010 Quasidea Development, LLC. All rights reserved.
//

#import "Strings.h"
#import "GTMNSString+HTML.h"


@implementation Strings

+ (NSString *)implodeObjectArray:(NSArray *)objArray WithSelector:(SEL)selSelector Glue:(NSString *)strGlue {
	NSInteger intCount = [objArray count];
	if (intCount == 0) return nil;

	NSMutableString * strToReturn = [[[NSMutableString alloc] initWithString:(NSString *)[[objArray objectAtIndex:0] performSelector:selSelector]] autorelease];
	for (NSInteger intIndex = 1; intIndex < intCount; intIndex++) {
		[strToReturn appendFormat:@"%@%@", strGlue, (NSString *)[[objArray objectAtIndex:intIndex] performSelector:selSelector]];
	}
	
	return [NSString stringWithString:strToReturn];
}

+ (NSString *)implodeArray:(NSArray *)strArray WithGlue:(NSString *)strGlue {
	NSInteger intCount = [strArray count];
	if (intCount == 0) return nil;

	NSMutableString * strToReturn = [[[NSMutableString alloc] initWithString:(NSString *)[strArray objectAtIndex:0]] autorelease];
	for (NSInteger intIndex = 1; intIndex < intCount; intIndex++) {
		[strToReturn appendFormat:@"%@%@", strGlue, (NSString *)[strArray objectAtIndex:intIndex]];
	}

	return [NSString stringWithString:strToReturn];
}

+ (NSString *)trimString:(NSString *)strString {
	return [strString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (NSString *)htmlEntities:(NSString *)strString {
	if (strString == nil) return @"";
	return [strString gtm_stringByEscapingForHTML];
}

+ (NSString *)escapeForXml:(NSString *)strString {
	if (strString == nil) return @"";
	return [NSString stringWithFormat:@"<![CDATA[%@]]>",
			[strString stringByReplacingOccurrencesOfString:@"]]>" withString:@"]]><![CDATA["]];
}

+ (NSString *)xmlDateStringForDate:(NSDate *)dttDate {
	if (dttDate == nil) return @"";

	NSDateComponents * objComponents = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit)
																	   fromDate:dttDate];

	NSDateFormatter * objDateFormatter = [[[NSDateFormatter alloc] init] autorelease];

	if (([objComponents hour] == 0) &&
		([objComponents minute] == 0) &&
		([objComponents second] == 0)) {
		// Date Only
		[objDateFormatter setDateFormat:@"yyyy-MM-dd"];
	} else {
		// Date AND Time which must include timezone
		[objDateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
	}

	return [objDateFormatter stringFromDate:dttDate];
}

@end