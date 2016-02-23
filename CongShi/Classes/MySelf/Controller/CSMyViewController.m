//
//  CSMyViewController.m
//  CongShi
//
//  Created by Archy on 16/1/8.
//  Copyright © 2016年 Archy. All rights reserved.
//

#import "CSMyViewController.h"
#import "CSMySideViewController.h"

@interface CSMyViewController ()

@property (nonatomic, strong) CSMySideViewController *mySide;

@end

@implementation CSMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.mySide = [[CSMySideViewController alloc] init];
    [self.mySide setBgRGB:0xFFFFFF];
    [self.view addSubview:self.mySide.view];
    self.mySide.view.frame  = self.view.bounds;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.mySide showHideSidebar];
}

@end
