//
//  WDUtil.m
//  location
//
//  Created by mac on 12-9-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "WDUtil.h"

@implementation WDUtil

+ (NSData *)reverseNSData:(NSData *)data{
    const char *bytes = [data bytes];
    char *reverseBytes = malloc(sizeof(char) * [data length]);
    int index = [data length] - 1;
    for (int i = 0; i < [data length]; i++)
        reverseBytes[index--] = bytes[i];
    NSData *reversedData = [NSData dataWithBytes:reverseBytes length:[data length]];
    free(reverseBytes);
    return reversedData;
}

@end
