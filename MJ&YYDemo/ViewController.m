//
//  ViewController.m
//  MJ&YYDemo
//
//  Created by 张张凯 on 2018/3/2.
//  Copyright © 2018年 TRS. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "DataModel.h"

#import "YYModel.h"
#import "MJExtension.h"
#import "GlobalUtil.h"

#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice]systemVersion]floatValue]>=10.0)? (YES):(NO))


#define AdapationLabelFont(n) (IOS_VERSION_10_OR_LATER?((n-1)*([[UIScreen mainScreen]bounds].size.width/375.0f)):((n)*([[UIScreen mainScreen]bounds].size.width/375.0f)))
@interface ViewController ()

@end

@implementation ViewController

static void getSuper(Class class, NSString *result) {
    if ([class superclass]) {
        getSuper([class superclass], result);
        NSLog(@"---------------class:%@------result:%@",NSStringFromClass(class),result);
    }
}

static NSString* getCarrier(NSString *carrier){
    
    return carrier;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    NSString *result = @"1234567890";
    getSuper([self class], result);
    NSString *carrier = @"中国移动";
    NSLog(@"张开发送了一个返回值：%@",getCarrier(carrier));
    
    NSString *url = [[NSString stringWithFormat:@"http://gank.io/api/data/all/20/1"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    NSDictionary *dict = @{@"format": @"json"};

    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //解析responseObject
        NSDictionary *dic = responseObject;
        
        /*
         MJExtention&YYModel内部原理相同，都是通过runtime获取字典相应的属性值然后再去一一匹配数据。
         */
        
        //1、MJExtention字典数组转模型数组
        NSArray *MJArr = [DataModel mj_objectArrayWithKeyValuesArray:dic[@"results"]];
        for (int i=0; i<MJArr.count; i++) {
            DataModel *model = MJArr[i];
//            NSLog(@"----------formodel:%@",model.who);
        }
        
        //2、YYModel字典转模型
        NSArray *YYArr = [NSArray yy_modelArrayWithClass:[DataModel class] json:dic[@"results"]];       
        [YYArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DataModel *model = YYArr[idx];
//            NSLog(@"----------enumerateObjectsUsingBlockmodel:%@",model.url);
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"数据发送请求失败");
    }];
    
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NotifationNetworking) name:@"123" object:nil];

}
- (void)NotifationNetworking{
    
    NSLog(@"设置的网络发送通知right");
//    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"标题" message:@"这个是UIAlertView的默认样式" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
//    [alertview show];

    // 1.创建UIAlertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:@"网路中断"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Delete Action");
    }];
    [alertController addAction:deleteAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"网络中断" message:@"网路请求失败"
//                                                                      preferredStyle:1];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//    [alertController addAction:cancelAction];
//    [alertController addAction:okAction];
   
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [GlobalUtil showWarningMsg:@"网络出问题啦" inView:self.view];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DataIsNil" object:nil];
}


@end
