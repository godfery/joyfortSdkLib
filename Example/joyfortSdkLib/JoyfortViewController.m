//
//  JoyfortViewController.m
//  joyfortSdkLib
//
//  Created by godfery on 12/21/2017.
//  Copyright (c) 2017 godfery. All rights reserved.
//

#import "JoyfortViewController.h"

#import <joyfortSdkLib/JoyfortCache.h>

@interface JoyfortViewController ()

@end

@implementation JoyfortViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   [ [JoyfortCache getInstance]  initParam:@"1" deviceid:@"3333333" extendDeviceid:@""];
    NSString *aa  = [[JoyfortCache getInstance ] loginCache:@"" password:@""];
    NSLog(@"%@",aa);
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
