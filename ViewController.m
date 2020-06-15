//
//  ViewController.m
//  ContactList
//
//  Created by chi on 2020/6/11.
//  Copyright © 2020 chi-ios. All rights reserved.
//

#import "ViewController.h"

#define kHeight 100

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    // Do any additional setup after loading the view.
    CGRect tableFrame = CGRectMake(10, kHeight + 100, 400, 300);
    CGRect filedFrame = CGRectMake(20, kHeight + 60, 300, 31);
    CGRect buttonFrame = CGRectMake(328, kHeight + 60, 72 , 31);
    
    self.contacts = [NSMutableArray array];
    
    //联系人表视图
    self.contactList = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [self.contactList registerClass:[ContactCell class] forCellReuseIdentifier:@"xxx"];
    self.contactList.sectionIndexBackgroundColor = [UIColor yellowColor];
    //设置表视图的数据源为当前对象
    self.contactList.dataSource = self;
    self.contactList.delegate = self;
    //创建单元格时，告诉UITableView对象对哪个类进行实例化
    //[self.contactList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.contactList];
    
    //搜索文本框
    self.searchField = [[UITextField alloc] initWithFrame:filedFrame];
    self.searchField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchField.placeholder = @"Add Name";
    [self.view addSubview:self.searchField];
    
    //按键
    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.button.frame = buttonFrame;
    [self.button setTitle:@"Add" forState:UIControlStateNormal];
    //设置按钮的目标-动作对
    [self.button addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    //searchBar
    CGRect searchBarFrame = CGRectMake(10, 60, 350, 40);
    self.searchBar = [[UISearchBar alloc] initWithFrame:searchBarFrame];
    self.searchBar.delegate = self;
    self.searchBar.showsCancelButton = YES;
    self.contactList.tableHeaderView = self.searchBar;
    
    
    
}

- (void)addTask:(id)sender {
    NSString *text = [self.searchField text];
    if([text length] == 0) return;
   // NSLog(@"Search Entered:%@",text);
    //加联系人添加到contacs数组中
    [self.contacts addObject:text];
    //重新载入数据
    [self.contactList reloadData];
    
    
    //清空searchField
    [self.searchField setText:@""];
    //关闭键盘
    [self.searchField resignFirstResponder];
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - 管理表格视图

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.string.length == 0) {
       return [self.contacts count];
    }
    else {
        return [self.resultContacts count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell *cell = [self.contactList dequeueReusableCellWithIdentifier:@"xxx"];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *item;
    if(self.string.length == 0) {
        item = [self.contacts objectAtIndex:indexPath.row];
    }
    else {
        item = [self.resultContacts objectAtIndex:indexPath.row];
    }
    cell.name.text = item;
    cell.phoneNumber.text = @"123456";
    return cell;
}



#pragma mark - 委托方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailView = [[DetailViewController alloc] init];
    //往后传数据
    detailView.nameString = [self.contacts objectAtIndex:indexPath.row];
    //使用block回调传数据
    detailView.callback = ^(NSString *str) {
        NSLog(@"%@",str);
        [self.contacts replaceObjectAtIndex:indexPath.row withObject:str];
        [self.contactList reloadData];
    };
    [self.navigationController pushViewController:detailView animated:YES];
    
}
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos) {
    
        UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            [self.contacts removeObjectAtIndex:indexPath.section];
            [self.contactList reloadData];
            completionHandler(YES);
        }];
        deleteAction.backgroundColor = [UIColor redColor];
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
        return config;
   
    
}


//searchBar方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSString* str = searchText;
    self.string = str;
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c]%@ ",str];
    //使用深拷贝复制contacts
    self.resultContacts = [[NSMutableArray alloc] initWithArray:self.contacts copyItems:YES];
    [self.resultContacts filterUsingPredicate:namePredicate];
    [self.contactList reloadData];
}

@end
