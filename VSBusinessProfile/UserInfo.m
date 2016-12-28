
//  UserInfo.m
//  VSBusinessProfile
//
//  Created by Admin on 12/22/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

-(id)initWithData:(NSData*)data idNum:(NSString*)idNum yelpString:(NSString*)yelpString

{
    self = [super init];
    if(self)
    {
        _data = data;
        _idNo=idNum;
        _yelpString=yelpString;
        
    }
    return self;
}

@end
