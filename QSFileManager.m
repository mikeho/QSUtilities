/**
 * QSFileManager.m
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

#import "QSFileManager.h"
#include <sys/xattr.h>

static NSString * _strDocumentsPath = nil;
static NSString * _strOfflineContentPath = nil;

@implementation QSFileManager

+ (NSString *)documentsFilePathForFile:(NSString *)strFile {
	if (_strDocumentsPath == nil) {
		NSArray * objPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
		_strDocumentsPath = [objPaths objectAtIndex:0];
		[_strDocumentsPath retain];
	}
	
	return [_strDocumentsPath stringByAppendingPathComponent:strFile];
}


+ (NSString *)offlineContentFilePathForFile:(NSString *)strFile {
	if (_strOfflineContentPath == nil) {
		NSArray * objPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, true);
		_strOfflineContentPath = [[objPaths objectAtIndex:0] stringByAppendingPathComponent:@"Offline Content"];
		[_strOfflineContentPath retain];
	}

	return [_strOfflineContentPath stringByAppendingPathComponent:strFile];
}

+ (bool)writeFile:(NSString *)strFilePath WithData:(NSData *)objData {
	return [[NSFileManager defaultManager] createFileAtPath:strFilePath contents:objData attributes:nil];
}

+ (NSData *)readFile:(NSString *)strFilePath {
	return [[NSFileManager defaultManager] contentsAtPath:strFilePath];
}

+ (bool)writeDocumentsFile:(NSString *)strFileName WithData:(NSData *)objData {
	return [QSFileManager writeFile:[QSFileManager documentsFilePathForFile:strFileName] WithData:objData];
}

+ (NSData *)readDocumentsFile:(NSString *)strFileName {
	return [QSFileManager readFile:[QSFileManager documentsFilePathForFile:strFileName]];
}

+ (bool)writeOfflineContentFile:(NSString *)strFileName WithData:(NSData *)objData {
	bool blnToReturn;
	blnToReturn = [QSFileManager writeFile:[QSFileManager offlineContentFilePathForFile:strFileName] WithData:objData];

	// Since we're dealing with Offline Content, we are required to set the "Do Not Back up" Extended Attribute
	if (blnToReturn) {
		blnToReturn = [QSFileManager markFileAsDoNotBackup:[QSFileManager offlineContentFilePathForFile:strFileName]];
	}

	return blnToReturn;
}

+ (bool)markFileAsDoNotBackup:(NSString *)strFileName {
	const char * strFilePath = [strFileName fileSystemRepresentation];
	const char * strAttributeName = "com.apple.MobileBackup";
	u_int8_t attrValue = 1;

	int result = setxattr(strFilePath, strAttributeName, &attrValue, sizeof(attrValue), 0, 0);
	return (result == 0);
}

+ (NSData *)readOfflineContentFile:(NSString *)strFileName {
	return [QSFileManager readFile:[QSFileManager offlineContentFilePathForFile:strFileName]];
}

+ (NSInteger)fileSize:(NSString *)strFilePath {
	NSDictionary * dctFileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:strFilePath error:NULL];	
	return [dctFileAttributes fileSize];
}

@end
