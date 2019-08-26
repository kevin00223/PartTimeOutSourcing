//
//  HGFeedBackViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/20.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGFeedBackViewController.h"
#import "HGMineViewController.h"

@interface HGFeedBackViewController ()

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *confirmButton;

@end

@implementation HGFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initValues];
    [self initSubviews];
}

- (void)initValues {
    self.title = @"意见反馈";
}

- (void)initSubviews {
    [self.view addSubview:self.textView];
    [self.view addSubview:self.confirmButton];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [self.view addGestureRecognizer:pan];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-15);
        make.height.offset(240);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.offset(45);
        make.width.offset(200);
        make.top.equalTo(self.textView.mas_bottom).offset(100);
    }];
}

- (void)confirmButtonClicked: (UIButton *)confirmButton {
    [self toDoAnythingWithInternet:^{
        for (UIViewController *vc in self.navigationController.childViewControllers) {
            if ([vc isKindOfClass:[HGMineViewController class]]) {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
        [MBProgressHUD showMessage:@"反馈已提交"];
    } isShowHud:YES];
}

- (void)panGesture: (UIGestureRecognizer *)panGesture {
    [self.view endEditing:YES];
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textColor = HGHexColor(0x959595);
        _textView.font = [UIFont systemFontOfSize:14];
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"请输入您的意见反馈";
        placeHolderLabel.textColor = HGHexColor(0x959595);
        placeHolderLabel.font = [UIFont systemFontOfSize:14];
        [placeHolderLabel sizeToFit];
        [_textView addSubview:placeHolderLabel];
        [_textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    }
    return _textView;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"feedback_confirm"] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

@end
