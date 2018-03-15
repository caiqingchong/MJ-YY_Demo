//
//  DataDodel.h
//  MJ&YYDemo
//
//  Created by 张张凯 on 2018/3/2.
//  Copyright © 2018年 TRS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *publishedAt;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url __attribute__((deprecated("url属性已过期")));
@property (nonatomic, copy) NSString *used;
@property (nonatomic, copy) NSString *who DEPRECATED_MSG_ATTRIBUTE("who属性已经被废弃");

@property (nonatomic, retain) NSArray *images;

@end
