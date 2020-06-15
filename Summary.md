[toc](ContactList的总结)
## 通讯录功能
   - 添加联系人，包含姓名、头像、号码
   - 点击联系人，跳转到联系人详情页，可修改联系人姓名
   - 支持左滑删除联系人
   - 支持联系人搜索功能
   - ----

  ## 联系人主页

   在联系人主页视图中添加三个UI组件：联系人列表(UITableView)、联系人添加栏(UITextField)、按钮(UIButton)。UITableView使用自定义的Cell，每个Cell显示联系人信息，包括姓名、头像和号码。UIButton添加了目标-操作方法，当点击按钮时，UITextField中的文本会被作为姓名添加到UITableView中。
 ### 1.UITableVIew
 
- 创建并设置UITableView对象

```
//ViewController.h中声明属性
@property  UITableView *contactList;
、、、
//ViewController.m中创建并设置UITableView对象
CGRect tableFrame = CGRectMake(10, kHeight + 100, 400, 300);
self.contactList = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
self.contactList.sectionIndexBackgroundColor = [UIColor yellowColor];

```
- 为UITableView提供数据
作为视图对象，UITableView对象不包括任何实际的数据，而是需要依赖另外一个对象来作为其数据源。将视图控制器(ViewController，UIViewController的子类)作为UITableView对象的数据源和代理，则ViewController必须遵循UITableViewDataSource和UITableViewDelegate协议。
<font color='red'> 为什么协议不添加也能正常执行 </font>


```
 self.contactList.dataSource = self;
 self.contactList.delegate = self;
```
- 使用自定义的Cell进行实例化
  在ContactCell.h中自定义了Cell，Cell中加入了一个UIImage用于显示头像，两个UILabel用来显示姓名和电话(头像和电话为默认值)。
 
 

```
@property (nonatomic) UIImageView *headImage;
@property (nonatomic) UILabel *name;
@property (nonatomic) UILabel *phoneNumber;
、、、、

//定义布局
- (void)layoutSubviews {
    [super layoutSubviews];

    self.headImage.frame = CGRectMake(0, 0, 40, 40);
    self.headImage.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.headImage];
    
    CGRect nameFrame = CGRectMake(45, 0, 80, 15);
    self.name.frame = nameFrame;
    [self.contentView addSubview:self.name];
    
    CGRect phoneNumberFrame = CGRectMake(45, 25, 80, 15);
    self.phoneNumber.frame = phoneNumberFrame;
    //self.phoneNumber.text = @"123456";
    [self.contentView addSubview:self.phoneNumber];

}

//部件初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImage *picture = [UIImage imageNamed:@"xiaoxin.jpg"];
        self.headImage = [[UIImageView alloc] initWithImage:picture];
        self.name = [[UILabel alloc] init];
        self.phoneNumber = [[UILabel alloc] init];
        
    }
    return self;  
}
```
当需要创建单元格时，告诉UITableView对象对哪个类进行实例化

```
//注册自定义Cell
 [self.contactList registerClass:[ContactCell class] forCellReuseIdentifier:@"xxx"];
```
UITableDataSource协议声明了两个必须方法：
 1. 根据指定的表格段索引给出相应表格段包含的行数，tableView:numberOfRowsInsection
 2. 根据指定的表格段索引和行索引给出相应的UITableViewCell对象：table:cellForRowAtIndexPath

```
//根据相应表格段索引给出行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   //根据搜索框的内容进行判断，无文本则显示原内容，有文本则显示搜索结果   
    if(self.string.length == 0) {
       return [self.contacts count];
    }
    else {
        return [self.resultContacts count];
    }
}

//相应表格段的Cell对象
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //自定义ContactCell对象，并定义了重用的方式
    ContactCell *cell = [self.contactList dequeueReusableCellWithIdentifier:@"xxx"];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //根据搜索框中是否有文本来设置所显示的内容
    NSString *item;
    if(self.string.length == 0) {
        item = [self.contacts objectAtIndex:indexPath.row];
    }
    else {
        item = [self.resultContacts objectAtIndex:indexPath.row];
    }
    //根据contacts中的内容，重新设置表格对象
    cell.name.text = item;
    cell.phoneNumber.text = @"123456";
    return cell;
}
```
### 2.UITextField
UITextField用来输入姓名文本

```
//声明属性
@property UITextField *searchField;
、、、
//创建并设置对象
self.searchField = [[UITextField alloc] initWithFrame:filedFrame];
self.searchField.borderStyle = UITextBorderStyleRoundedRect;
self.searchField.placeholder = @"Add Name";
[self.view addSubview:self.searchField];
```
### 3.UIButton
首先创建并设置UIButton，然后为按键关联动作方法。当按下UIButton之后，UITextField中的文本将被作为姓名添加到Contacts联系人数组中，数组中的内容将会在表格中显示出来。

```
@property UIButton *button;
、、、
//创建并设置
self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
self.button.frame = buttonFrame;
[self.button setTitle:@"Add" forState:UIControlStateNormal];
//设置按钮的目标-动作对
[self.button addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
[self.view addSubview:self.button];
、、、
//按键方法
- (void)addTask:(id)sender {
    NSString *text = [self.searchField text];
    if([text length] == 0) return;
   // NSLog(@"Search Entered:%@",text);
    //将联系人添加到contacs数组中
    [self.contacts addObject:text];
    //重新载入数据
    [self.contactList reloadData];
    //清空searchField
    [self.searchField setText:@""];
    //关闭键盘
    [self.searchField resignFirstResponder];
}
```
- 对结尾resignFirstResponder的补充
有的视图对象也是控件。控件是可以与用户进行交互的视图，例如，按钮、滑块和输出框。当屏幕的视图中包含这类控件时，其中的某一个控件可以成为first responder。拥有第一响应状态的控件，可以处理来自键盘的文字输入及摇动事件。
当用户和某个控件产生交互，并且成为第一响应对象时，它会收到becomeFirstResponder消息。当接受文本的输入控件（如输入框）成为第一响应对象时，屏幕会出现一个键盘。成为第一响应对象的对象能够接收来自键盘的输入和摇动事件，并且会保持这一状态，直到另一个UIControl对象成为第一响应对象，或者是收到resignFirstResponder消息。所以在addTask:结尾处，程序会取消输入框的第一响应状态，以此来关闭键盘。
---
### 4.UISearchBar
在UISearchBar中输入文本，可对联系人列表进行检索，检索会在原列表上显示搜索结果。

- 添加UISearchBar，添加UISearchBarDelegate协议

```
//声明
@property UISearchBar *searchBar;
、、、
//创建并设置
self.searchBar = [[UISearchBar alloc] initWithFrame:searchBarFrame];
//声明代理
self.searchBar.delegate = self;
//取消按钮
self.searchBar.showsCancelButton = YES;
//设置为表头
self.contactList.tableHeaderView = self.searchBar;

```
- 重写searchBar:textDidChange:方法：在搜索框文本变化时，更新列表

```
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSString* str = searchText;
    //利用string的长度来判断搜索框是否有输入
    self.string = str;
     //使用深拷贝复制contacts
    self.resultContacts = [[NSMutableArray alloc] initWithArray:self.contacts copyItems:YES];
    //搜索
    NSPredicate *namePredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c]%@ ",str];
    [self.resultContacts filterUsingPredicate:namePredicate];
    //重新载入数据
    [self.contactList reloadData];
}		
```

### 5.添加滑动删除功能
添加滑动删除功能，增加协议UIScrollViewDelegate

```
- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(tvos) {
    
        UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"删除" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
            //删除联系人数组Contacts中对应的项
            [self.contacts removeObjectAtIndex:indexPath.section];
            [self.contactList reloadData];
            completionHandler(YES);
        }];
        deleteAction.backgroundColor = [UIColor redColor];
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
        return config;
}
```
### 6.页面跳转
当点击联系人时，会跳转到联系人详情页(DetailViewController)。在详情页中，UITextField会显示当前联系人的姓名，可以修改联系人姓名，按Modify按钮会返回联系人列表页并修改姓名。
（若不注明，均在tableView:didSelectRowAtIndexPath:委托方法中添加）

- 页面跳转
  采用UINavigationController的方式进行页面切换，UINavigationController以栈的方式管理视图，各个视图的切换就是压栈和出栈操作，出栈后的视图会立即销毁。只有在栈顶的控制器能够显示在界面中，一旦一个子控制器出栈则会被销毁。UINavigationController默认也不会显示任何视图（这个控制器自身的UIView不会显示），它必须有一个根控制器rootViewController，而且这个根控制器不会像其他子控制器一样被销毁。

```
//在AppDelegate.hzhong
@property (nonatomic, strong) UIWindow *window;
、、、
//在AppDelegate.m中，添加以下方法
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //创建并设置UIWindow
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
   //实例化ViewController
    ViewController *vc = [ViewController new];
    //实例化UINavigationController，将vc设置为它的根视图控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    //设置nav为window的根视图控制器
    self.window.rootViewController = nav;
    //显示
    [self.window makeKeyAndVisible];
    
    return YES;
}
、、、
//ViewController的tableView:didSelectRowAtIndexPath:中添加
//实例化详情页
DetailViewController *detailView = [[DetailViewController alloc] init];
//将页面push到栈中
 [self.navigationController pushViewController:detailView animated:YES];
```
- 向后传数据
 为了让联系人详情页的UITextField中显示当前姓名，需要向后传递数据
 

```
    detailView.nameString = [self.contacts objectAtIndex:indexPath.row];
```
- 向前传数据
  当按下Modify按钮时，需要将UITextfield中的内容传回。使用block回调的方式来完成
  
```
detailView.callback = ^(NSString *str) {
        NSLog(@"%@",str);
        //将contacts数组中的对应元素设置为回传的参数str
        [self.contacts replaceObjectAtIndex:indexPath.row withObject:str];
        //重载数据
        [self.contactList reloadData];
    };
```
---

  ## 联系人详情页
  联系人详情页包括一个UILabel用来标明姓名栏，一个UITextField用来编辑姓名，一个UIButton用来确认修改并返回，还声明了一个块用来回传数据给联系人列表页。
  1.UILabel、UITextField、UIButton的创建和声明
  

```
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
```
2. 在按钮方法中使用callback回传数据，并将联系人详情页弹出栈

```
- (void) editName:(id)sender {
    if (self.callback) {
        self.callback([NSString  stringWithString:self.editField.text]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
```
----
## Cell复用原理
TableView的重用机制，为了做到显示和数据分离，IOS tableView的实现并且不是为每个数据项创建一个tableCell。而是只创建屏幕可显示最大个数的cell，然后重复使用这些cell，对cell做单独的显示配置，来达到既不影响显示效果，又能充分节约内容的目的。
重用过程中，visiableCells内保存当前显示的cells，reusableTableCells保存可重用的cells。拖动屏幕时，当一个Cell完全移出屏幕，它就从visableCells移出，加入到reusableTableCells中。同时新建或者从reusableTableCell中取出一个Cell加入到visableCells中。

---
[iOS-UITableviewCell的重用机制
](https://www.jianshu.com/p/481f8fdfb9e0)

---
## Delegate设计模式
delegate设计模式就是让代理方帮助委托方实现协议中的方法。代理模式减少了对象之间的耦合性。Objective-C不支持多继承，但 Delegate 弥补了这个缺陷。 有了Delegate, 在声明对象时，可以使其遵循多个协议。 从而解决了多继承问题。

---
[Delegate设计模式](https://www.jianshu.com/p/b8da12f32046)

---

## Block对象
Block对象是一段代码，它可以被当作实参来传递。引用外部变量时，对于基本类型变量，使用block对象内的局部变量保存。对指针类型的变量，block对象会使用强引用。这意味这凡是block对象引用到的对象，都会被保留。所以使用时要注意避免强引用循环。
## 回调
回调就是将一段可执行的代码和一个特定的事件绑定起来。当特定的事件发生时，就会执行这段代码。实现回调的途径有四种：
1. 目标-动作对：目标是接收消息的对象，消息的选择器（selector）是动作。
2. 辅助对象：委托对象和数据源是常见的辅助对象。
3. 通知，当事件发生时，相关的对象会向通知中心发布通知，然后再由通知中心将通知转发给正在等待该通知的对象。
4. Block对象：Block对象是一段可执行代码。当事件发生时，执行这段Block对象


  
