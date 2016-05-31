//
//  DateModle.m
//  FeiYong
//
//  Created by 周大钦 on 16/5/27.
//  Copyright © 2016年 ldj. All rights reserved.
//

#import "DateModle.h"
#import <objc/message.h>

@implementation DateModle

@end

@implementation SAutoEx

-(id)initWithObj:(NSDictionary*)obj
{
    self = [super init];
    if( self && obj )
    {
        [self fetchIt:obj];
    }
    return self;
}

-(void)fetchIt:(NSDictionary*)obj
{
    if( obj == nil ) return;
    NSMutableDictionary* nameMapProp = NSMutableDictionary.new;
    id leaderClass = [self class];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(leaderClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        [nameMapProp setObject:[NSString stringWithFormat:@"%s",property_getAttributes(property)] forKey:propName];
    }
    if( properties )
    {
        free( properties );
    }
    
    if( nameMapProp.count == 0 ) return;
    
    NSArray* allnames = [nameMapProp allKeys];
    for ( NSString* oneName in allnames ) {
        if( ![oneName hasPrefix:@"m"] ) continue;
        //mId....like this
        NSString* jsonkey = [oneName stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:[[oneName substringWithRange:NSMakeRange(1, 1)] lowercaseString] ];
        //mId ==> mid;
        jsonkey = [jsonkey substringFromIndex:1];
        //mid ==> id;
        id itobj = [obj objectForKey:jsonkey];
        
        if( itobj == nil ) continue;
        
        
        
        [self setValue:itobj forKey:oneName];
    }
}
@end
