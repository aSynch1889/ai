//
//  ISVPleaseUpdateViewController.m
//  ISV
//
//  Created by aaaa on 16/1/25.
//  Copyright © 2016年 ISV. All rights reserved.
//

#import "ISVPleaseUpdateViewController.h"

@interface ISVPleaseUpdateViewController ()

@end

@implementation ISVPleaseUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)updateClick {
    
    if (NotNilAndNull(self.updateUrl) && self.updateUrl.length) {
        UIApplication *application = [UIApplication sharedApplication];
        [application openURL:[NSURL URLWithString:self.updateUrl]];
    }
}

@end
