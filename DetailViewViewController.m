//
//  DetailViewViewController.m
//  ContactList
//
//  Created by chi on 2020/6/11.
//  Copyright © 2020 chi-ios. All rights reserved.
//

#import "DetailViewViewController.h"

#define kHeight 100

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //nameLabel
    CGRect labelFrame = CGRectMake(10, kHeight + 40, 50, 30);
    self.namelabel = [[UILabel alloc] initWithFrame:labelFrame];
    self.namelabel.text = @"Name";
    [self.view addSubview:self.namelabel];
    
    //editField
    CGRect fieldFrame = CGRectMake(70, kHeight + 40, 150, 30);
    self.editField = [[UITextField alloc] initWithFrame:fieldFrame];
    self.editField.text = self.nameString;
    self.editField.borderStyle = UITextBorderStyleRoundedRect;
    self.editField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.editField];
    
    //button
    CGRect buttonFrame = CGRectMake(240, kHeight + 40, 100, 30);
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button.frame = buttonFrame;
    [self.button setTitle:@"Modify" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    //为按钮关联动作方法
    [self.button addTarget:self action:@selector(editName:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.callback) {
        self.callback(5, [NSString stringWithString:self.editField.text]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
*/
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) editName:(id)sender {
    if (self.callback) {
        self.callback([NSString  stringWithString:self.editField.text]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end
