//
//  QYViewControllerManager.m
//  WeiBo
//
//  Created by qingyun on 15-4-20.
//  Copyright (c) 2015年 hnqingyun.com. All rights reserved.
//

#import "QYViewControllerManager.h"

#import "QYGuideVC.h"
#import "QYMainViewController.h"
#import "AppDelegate.h"

#define kAPP_VERSION @"kAPP_VERSION"

@implementation QYViewControllerManager


//通过版本号，控制是否显示新特性页面

+(id)getRootViewVC{
    //根据标识返回相应的控制器
    
    //保存的app版本
    NSString *app = [[NSUserDefaults standardUserDefaults] objectForKey:kAPP_VERSION];
    
    //当前app版本
    NSString *currentAPP = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]];
    
    UIStoryboard *sotory = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    //如果版本一样，则显示主控制器
    if ([app isEqualToString:currentAPP]) {
        return [sotory instantiateViewControllerWithIdentifier:@"mainvc"];
    }else{
        return [sotory instantiateViewControllerWithIdentifier:@"guide"];
    }
    
}


+(void)guideEnd{
    //引导结束，保存已经使用过的版本
    NSString *currentAPP = [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey]];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:currentAPP forKey:kAPP_VERSION];
    [userDefault synchronize];
    
    //切换根控制器
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    UIStoryboard *sotory = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    delegate.window.rootViewController = [sotory instantiateViewControllerWithIdentifier:@"mainvc"];
}

@end
