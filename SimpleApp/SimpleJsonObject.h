//
//  SimpleJsonObject.h
//  SimpleApp
//
//  Created by Edward Louw on 6/8/15.
//  Copyright (c) 2015 Edward Louw. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* ID_KEY = @"id";
static NSString* TYPE_KEY = @"type";
static NSString* DATE_KEY = @"date";
static NSString* DATA_KEY = @"data";

static NSString* TEXT_TYPE = @"text";
static NSString* IMAGE_TYPE = @"image";
static NSString* OTHER_TYPE = @"other";

typedef enum : NSUInteger {
    TableTypeAll,
    TableTypeText,
    TableTypeImage
} TableTypes;

typedef enum : NSUInteger {
    SimpleTypeText,
    SimpleTypeImage,
    SimpleTypeOther
} SimpleTypes;

@interface SimpleJsonObject : NSObject

@property (strong, nonatomic) NSString* identification;
@property (assign, nonatomic) int type;
@property (strong, nonatomic) NSString* date;
@property (strong, nonatomic) NSString* data;

@end

@interface SimpleJsonObjectContainer : NSObject

- (id)initWithJSON:(NSData*)jsonData;
- (SimpleJsonObject*)objectAtIndex:(NSInteger)index;
- (SimpleJsonObject*)textObjectAtIndex:(NSInteger)index;
- (SimpleJsonObject*)imageObjectAtIndex:(NSInteger)index;
- (NSUInteger)count:(TableTypes)tableType;

@end
