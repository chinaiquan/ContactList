//
//  DetailViewViewController.h
//  ContactList
//
//  Created by chi on 2020/6/11.
//  Copyright © 2020 chi-ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (nonatomic) UILabel *namelabel;
@property (nonatomic) UITextField *editField;
@property (nonatomic) UIButton *button;


@property (nonatomic,copy) NSString *nameString;

@property (nonatomic, copy) void(^callback)(NSString *str);

@end

NS_ASSUME_NONNULL_END
