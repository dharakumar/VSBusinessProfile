//
//  UserInfo.h
//  VSBusinessProfile
//
//  Created by Admin on 12/22/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (nonatomic ,strong) NSData *data ;
@property (nonatomic,strong) NSString *idNo;
@property (nonatomic,strong) NSString *yelpString;
-(id)initWithData:(NSData*)data idNum:(NSString*)idNum yelpString:(NSString*)yelpString;
@end
