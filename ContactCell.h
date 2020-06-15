//
//  ContactCell.h
//  ContactList
//
//  Created by chi on 2020/6/11.
//  Copyright © 2020 chi-ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactCell : UITableViewCell

@property (nonatomic) UIImageView *headImage;
@property (nonatomic) UILabel *name;
@property (nonatomic) UILabel *phoneNumber;

@end

NS_ASSUME_NONNULL_END
