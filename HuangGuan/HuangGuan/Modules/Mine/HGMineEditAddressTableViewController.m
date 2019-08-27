//
//  HGMineEditAddressTableViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGMineEditAddressTableViewController.h"

@interface HGMineEditAddressTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UISwitch *defaultSwitch;

@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation HGMineEditAddressTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.addressType == EditAddressTypeEdit) {
        self.title = @"编辑地址";
        UIBarButtonItem *confirmBtn = [UIBarButtonItem itemWithTitle:@"删除" Image:nil target:self action:@selector(deleteBtnClick)];
        self.navigationItem.rightBarButtonItem = confirmBtn;
        self.phoneTextField.text = _addressData.mobile;
        self.nameTextField.text = _addressData.name;
        self.addressTextField.text = _addressData.address;
        self.defaultSwitch.on = _addressData.isDefault;
    } else {
        self.title = @"新增地址";
    }
    
    self.tableView.estimatedSectionFooterHeight = 1;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.saveButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.saveButton setHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.saveButton setHidden:YES];
}

- (void)deleteBtnClick {
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"bg_id"),bg_sqlValue(_addressData.bg_id)];
    [HGAddressModel bg_delete:@"addressDB" where:where];
    [self toDoAnythingWithInternet:^{
        [self.navigationController popViewControllerAnimated:YES];
        [MBProgressHUD showSuccess:@"删除成功"];
    } isShowHud:YES];
}

- (void)saveButtonClicked: (UIButton *)button {
    if (![self.addressTextField.text isNotBlank] || ![self.phoneTextField.text isNotBlank] || ![self.nameTextField.text isNotBlank]) {
        [MBProgressHUD showError:@"请填写完整的信息"];
        return;
    }
    
    if (self.defaultSwitch.on) {
        
        NSString* where = [NSString stringWithFormat:@"where %@=%@ and %@=%@",bg_sqlKey(@"isDefault"),bg_sqlValue(@1),bg_sqlKey(@"userMobile"),bg_sqlValue([JHUserDefaults shareInstance].mobile)];
        NSArray* arr = [HGAddressModel bg_find:@"addressDB" where:where];
        if (arr.count != 0) {
            HGAddressModel *address = arr.firstObject;
            bg_executeSql([NSString stringWithFormat:@"update addressDB set BG_isDefault = 0 where BG_bg_id = '%@'",address.bg_id], nil, nil);//更新或删除等操作时,后两个参数不必传入.
        }
    }
    
    if (self.addressType == EditAddressTypeNew) {
        HGAddressModel *address = [[HGAddressModel alloc] init];
        address.address = self.addressTextField.text;
        address.mobile = self.phoneTextField.text;
        address.name = self.nameTextField.text;
        address.isDefault = self.defaultSwitch.isOn;
        address.bg_tableName = @"addressDB";
        address.userMobile = [JHUserDefaults shareInstance].mobile;
        [address bg_save];
    } else {
        bg_executeSql([NSString stringWithFormat:@"update addressDB set BG_name='%@',BG_mobile = '%@',BG_address = '%@',BG_isDefault = %d where BG_bg_id = '%@'",self.nameTextField.text,self.phoneTextField.text,self.addressTextField.text,self.defaultSwitch.isOn,_addressData.bg_id], nil, nil);//更新或删除等操作时,后两个参数不必传入.
    }
    [self toDoAnythingWithInternet:^{
        [self.navigationController popViewControllerAnimated:YES];
    } isShowHud:YES];
}

#pragma mark - tableview

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIButton *)saveButton {
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.frame = CGRectMake(0, kScreenHeight-44, kScreenWidth, 44);
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        _saveButton.backgroundColor = HGHexColor(0xEB5266);
        [_saveButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}


@end
