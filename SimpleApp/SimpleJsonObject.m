//
//  SimpleJsonData.m
//  SimpleApp
//
//  Created by Edward Louw on 6/8/15.
//  Copyright (c) 2015 Edward Louw. All rights reserved.
//

#import "SimpleJsonObject.h"

@interface SimpleJsonObject ()

@end

@implementation SimpleJsonObject

@end

@interface SimpleJsonObjectContainer ()

@property (strong, nonatomic) NSMutableArray* dataObjects;
@property (strong, nonatomic) NSMutableArray* textList;
@property (strong, nonatomic) NSMutableArray* imageList;

@end

@implementation SimpleJsonObjectContainer

- (id)initWithJSON:(NSData *)jsonData {
    if(self = [super init]) {
        NSError* error;
        NSArray* deserializedData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        self.dataObjects = [[NSMutableArray alloc] initWithCapacity:deserializedData.count];
        self.textList = [[NSMutableArray alloc] initWithCapacity:deserializedData.count];
        self.imageList = [[NSMutableArray alloc] initWithCapacity:deserializedData.count];
        [self processDataObjects:deserializedData];
    }
    return self;
}

-(NSUInteger)count:(TableTypes)tableType {
    NSUInteger retVal = 0;
    switch (tableType) {
        case TableTypeText:
            retVal = self.textList.count;
            break;
        case TableTypeImage:
            retVal = self.imageList.count;
            break;
        default:
            retVal = self.dataObjects.count;
            break;
    }
    return retVal;
}

-(SimpleJsonObject*)objectAtIndex:(NSInteger)index {
    SimpleJsonObject* retVal = nil;
    if(index < self.dataObjects.count) {
        retVal = self.dataObjects[index];
    }
    return retVal;
}

-(SimpleJsonObject*)textObjectAtIndex:(NSInteger)index {
    SimpleJsonObject* retVal = nil;
    if(index < self.textList.count) {
        NSNumber* mappedIndex = self.textList[index];
        retVal = self.dataObjects[mappedIndex.integerValue];
    }
    return retVal;
}

-(SimpleJsonObject*)imageObjectAtIndex:(NSInteger)index {
    SimpleJsonObject* retVal = nil;
    if(index < self.imageList.count) {
        NSNumber* mappedIndex = self.imageList[index];
        retVal = self.dataObjects[mappedIndex.integerValue];
    }
    return retVal;
}

-(void)processDataObjects:(NSArray*) deserializedData {
    for(NSDictionary* item in deserializedData) {
        NSString* typeString = item[TYPE_KEY];
        SimpleJsonObject* jsonData = [[SimpleJsonObject alloc] init];
        jsonData.identification = item[ID_KEY];
        jsonData.date = item[DATE_KEY];
        jsonData.data = item[DATA_KEY];
        if([typeString isEqualToString:TEXT_TYPE]) {
            jsonData.type = SimpleTypeText;
            [self.textList addObject:@(self.dataObjects.count)];
        } else if([typeString isEqualToString:IMAGE_TYPE]) {
            jsonData.type = SimpleTypeImage;
            [self.imageList addObject:@(self.dataObjects.count)];
        } else {
            jsonData.type = SimpleTypeOther;
        }
        [self.dataObjects addObject:jsonData];
    }
}

@end
