//
//  GlobalUtil.m
//  MJ&YYDemo
//
//  Created by 张张凯 on 2018/3/14.
//  Copyright © 2018年 TRS. All rights reserved.
//

#import "GlobalUtil.h"
#define _ZBMScreenWidth [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define _ZBMScreenHeight [UIScreen mainScreen].bounds.size.height

#define Default_Font(num)   [UIFont systemFontOfSize:num]





@implementation GlobalUtil




// 显示一帮警告信息，从底部弹出，延迟1.5秒自动消失
+ (void)showWarningMsg:(NSString *)warning inView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = Default_Font(14.0);
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85f];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 6.f;
    label.layer.masksToBounds = YES;
    label.text = [NSString stringWithFormat:@"提示: %@", warning];
    label.alpha = 0;
    [view addSubview:label];
    
    CGSize size = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    label.frame = CGRectMake((_ZBMScreenWidth - size.width - 40.f)/2.f, (_ZBMScreenHeight - size.height * 3.f)/2.f, size.width + 40.f, size.height * 5);
    
    [UIView animateWithDuration:0.6 animations:^{
        label.alpha = 1;
    } completion:^(BOOL finished){
        if (finished) {
            [UIView animateWithDuration:0.6 delay:1.5 options:UIViewAnimationOptionLayoutSubviews animations:^{
                label.alpha = 0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [label removeFromSuperview];
                }
            }];
        }
    }];
}


@end
