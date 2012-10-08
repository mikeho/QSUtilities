/**
 * QSFileManager.h
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

#import <Foundation/Foundation.h>


@interface QSFileManager : NSObject {

}

+ (NSString *)documentsFilePathForFile:(NSString *)strFile;
+ (bool)writeDocumentsFile:(NSString *)strFileName WithData:(NSData *)objData;
+ (NSData *)readDocumentsFile:(NSString *)strFileName;

+ (NSString *)offlineContentFilePathForFile:(NSString *)strFile;
+ (bool)writeOfflineContentFile:(NSString *)strFileName WithData:(NSData *)objData;
+ (NSData *)readOfflineContentFile:(NSString *)strFileName;

+ (bool)markFileAsDoNotBackup:(NSString *)strFileName;

+ (bool)writeFile:(NSString *)strFilePath WithData:(NSData *)objData;
+ (NSData *)readFile:(NSString *)strFilePath;
+ (NSInteger)fileSize:(NSString *)strFilePath;

@end
