//
//  ContactCell.m
//  ContactList
//
//  Created by chi on 2020/6/11.
//  Copyright © 2020 chi-ios. All rights reserved.
//

#import "ContactCell.h"

@implementation ContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImage *picture = [UIImage imageNamed:@"xiaoxin.jpg"];
        self.headImage = [[UIImageView alloc] initWithImage:picture];
        self.headImage.frame = CGRectMake(0, 0, 40, 40);
        self.headImage.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:self.headImage];
        
        
        CGRect nameFrame = CGRectMake(45, 0, 80, 15);
        self.name = [[UILabel alloc] init];
        self.name.frame = nameFrame;
        //self.name.text=@"xiaoxin";
        [self.contentView addSubview:self.name];
        
        CGRect phoneNumberFrame = CGRectMake(45, 25, 80, 15);
        self.phoneNumber = [[UILabel alloc] init];
        self.phoneNumber.frame = phoneNumberFrame;
        //self.phoneNumber.text = @"123456";
        [self.contentView addSubview:self.phoneNumber];
    }
    
    
    
    return self;
    
    
}

@end
