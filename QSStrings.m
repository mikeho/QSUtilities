/**
 * QSStrings.m
 * 
 * Copyright (c) 2010 - 2011, Quasidea Development, LLC
 * For more information, please go to http://www.quasidea.com/
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "QSUtilities.h"
#import "GTMNSString+HTML.h"


@implementation QSStrings

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