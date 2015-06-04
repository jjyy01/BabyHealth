//
//  HomeViewController.m
//  BabyHealth
//
//  Created by jiwei on 15/6/4.
//  Copyright (c) 2015年 weiji.info. All rights reserved.
//

#import "HomeViewController.h"
#import "Common.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searched;
@property (weak, nonatomic) IBOutlet UIView *searchedBackgroundView;

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
    
    
}

-(void)showKeyboard:(NSNotification *)notification{
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    DBLog(@"%@", value);
    CGRect keyboardFrame = [value CGRectValue];
    UIWindow *window = self.view.window;
    if (window.frame.size.height > keyboardFrame.origin.y) {
        self.view.frame = CGRectOffset(self.view.frame, 0, -200);

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)dictation:(id)sender {
    
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

@end
