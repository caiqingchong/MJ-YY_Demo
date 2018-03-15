//
//  UIFont+adapt.m
//  MJ&YYDemo
//
//  Created by 张张凯 on 2018/3/14.
//  Copyright © 2018年 TRS. All rights reserved.
//

#import "UIFont+adapt.h"

@implementation UIFont (adapt)

+ (void)load{
    //获取原类方法
    Method method = class_getClassMethod([self class], @selector(systemFontOfSize:));
    
    //获取替换类的方法
    Method newMethod = class_getClassMethod([self class], @selector(adjustFont:));
    
    //交换类方法  第一个是新的方法，第二个是原方法
    method_exchangeImplementations(newMethod, method);
}



+(UIFont *)adjustFont:(CGFloat)fontSize{
    UIFont *newFont=nil;
    /*
     * 如果是iPhone 5s屏幕大小就是原字体。
     * 如果是iPhone 6屏幕大小就增加两个字号
     * 如果是iPhone 6s屏幕大小就增加三个字号
     eg:
     iPhone 5s  font:15
     iPhone 6   font:17
     iPhone 6s  font:18
     */
    if (IS_IPHONE_6){
        newFont = [UIFont adjustFont:fontSize + IPHONE6_INCREMENT];
    }else if (IS_IPHONE_6_PLUS){
        newFont = [UIFont adjustFont:fontSize + IPHONE6PLUS_INCREMENT];
    }else{
        newFont = [UIFont adjustFont:fontSize];
    }
    return newFont;
    
}


@end
