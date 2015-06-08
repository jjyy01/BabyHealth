//
//  HomeViewController.m
//  BabyHealth
//
//  Created by jiwei on 15/6/4.
//  Copyright (c) 2015年 weiji.info. All rights reserved.
//

#import "HomeViewController.h"
#import "Common.h"
#import "iflyMSC/IFlyRecognizerViewDelegate.h"
#import "iflyMSC/IFlySpeechConstant.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "iflyMSC/IFlyRecognizerView.h"


@interface HomeViewController ()<IFlyRecognizerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searched;
@property (weak, nonatomic) IBOutlet UIView *searchedBackgroundView;
//带界面的语音识别控件
@property (strong, nonatomic) IFlyRecognizerView *recongnizerView;

@end

@implementation HomeViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //键盘位置改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.recongnizerView = [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
    self.recongnizerView.delegate = self;
    
    
}



-(void)showKeyboard:(NSNotification *)notification{
//    取出键盘将要到达的位置
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    DBLog(@"%@", value);
    CGRect keyboardFrame = [value CGRectValue];
    
    //根window比较，看是否在win内
    UIWindow *window = self.view.window;
    if (window.frame.size.height > keyboardFrame.origin.y) {
        //view的移动的动画时间根键盘一样
        NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        
        [UIView animateWithDuration:[duration doubleValue] - 0.5 animations:^{
            self.view.frame = CGRectOffset(self.view.frame, 0, -200);
        }];
    }else{
        NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        [UIView animateWithDuration:[duration doubleValue] animations:^{
            self.view.frame = CGRectOffset(self.view.frame, 0, 200);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)dictation:(id)sender {
    
    //设置为普通的语音识别
    [self.recongnizerView setParameter: @"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    //设置结果数据格式，可设置为json，xml，plain，默认为json。
    [self.recongnizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    [self.recongnizerView start];
    
    NSLog(@"start listenning...");
    
}

- (IBAction)searchAction:(id)sender {
}

- (IBAction)share:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark IFlyRecognizerViewDelegate

/** 识别结果回调方法
 @param resultArray 结果列表
 @param isLast YES 表示最后一个，NO表示后面还有结果
 */
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    
    self.searched.text = result;
    
    [self.recongnizerView cancel];
}

/** 识别结束回调方法
 @param error 识别错误
 */
- (void)onError:(IFlySpeechError *)error
{
    
    NSLog(@"errorCode:%d",[error errorCode]);
}


@end
