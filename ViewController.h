//
//  ViewController.h
//  ContactList
//
//  Created by chi on 2020/6/11.
//  Copyright © 2020 chi-ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactCell.h"
#import "DetailViewViewController.h"


@interface ViewController : UIViewController<UIApplicationDelegate,UITableViewDelegate,UITableViewDataSource,NSObject, UIScrollViewDelegate,UISearchBarDelegate>

@property  UITableView *contactList;
@property UITextField *searchField;
@property UIButton *button;
@property UISearchBar *searchBar;




@property NSMutableArray *contacts;
@property NSMutableArray *resultContacts;
@property NSString *string;

- (void)addTask:(id)sender;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@end

