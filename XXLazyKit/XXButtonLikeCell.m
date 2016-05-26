//
//  XXButtonLikeCell.m
//  Demo
//
//  Created by 王旭 on 16/5/25.
//  Copyright © 2016年 Pitt. All rights reserved.
//

#import "XXButtonLikeCell.h"
#import "Masonry.h"
#import "UIColor+XXExtension.h"
#import "UIFont+XXExtension.h"
#import "UIView+XXExtension.h"
#import "XXLazyCreateView.h"

@interface XXButtonLikeCell ()

@property (nonatomic ,strong) UILabel *leftTitleLabel;
@property (nonatomic ,strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic ,strong) UIView *line;
@property (nonatomic ,strong) UITextField *textField;

@property (nonatomic ,strong) UISwitch *selectedView;

@end

@implementation XXButtonLikeCell


- (void)addTarget:(id)target action:(SEL)action messageSide:(XXButtonLikeCellMessageSide)messageSide Title:(NSString *)title Tag:(NSInteger)tag {
    self.title = title;
    self.tag = tag;
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    switch (messageSide) {
            case XXButtonLikeCellMessageSideLeft:
            self.messageLabel.textAlignment = NSTextAlignmentLeft;
            self.textField.textAlignment = NSTextAlignmentLeft;
            break;
            case XXButtonLikeCellMessageSideRight:
            self.messageLabel.textAlignment = NSTextAlignmentRight;
            self.textField.textAlignment = NSTextAlignmentRight;
            break;
            case XXButtonLikeCellMessageSideCenter:
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            self.textField.textAlignment = NSTextAlignmentCenter;
            break;
    }
}

- (void)setQuickEditWithKeyboardType:(UIKeyboardType) keyboardType {
    self.textField.hidden = NO;
    self.textField.keyboardType = keyboardType;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.leftTitleLabel.text = title;
}
- (void)setMessage:(NSString *)message {
    self.messageLabel.text = message;
}
- (NSString *)message {
    return self.messageLabel.text ? self.messageLabel.text : self.textField.text;
}
- (void)setSwitchOn:(BOOL)switchOn {
    self.selectedView.on = switchOn;
}
- (BOOL)switchOn {
    return self.selectedView.isOn;
}
-(void)setLineHidden:(BOOL)lineHidden {
    _lineHidden = lineHidden;
    self.line.hidden = lineHidden;
}

- (void)setAccessoryType:(XXButtonLikeCellAccessoryType)accessoryType {
    _accessoryType = accessoryType;
    
    if (accessoryType == XXButtonLikeCellAccessoryIndicator ) {
        
#define XXLazyKitSrcName(file) [@"XXLazyKit.bundle" stringByAppendingPathComponent:file]
#define XXLazyKitFrameworkSrcName(file) [@"Frameworks/XXLazyKit.framework/XXLazyKit.bundle" stringByAppendingPathComponent:file]
    UIImage *image = [UIImage imageNamed:XXLazyKitSrcName(@"XXLazyArrowr.png")] ?: [UIImage imageNamed:XXLazyKitFrameworkSrcName(@"XXLazyArrowr.png")];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = image;
        imageView.frame = CGRectMake(0, 0, 7, 11);
        [self setupRightViewSubView:imageView];
        
    }else if (accessoryType == XXButtonLikeCellAccessorySwitch) {
        self.selectedView = [[UISwitch alloc]init];
        [self setupRightViewSubView:self.selectedView];
    }
}
- (void)setAccessoryView:(UIView *)accessoryView {
    _accessoryView = accessoryView;
    [self setupRightViewSubView:accessoryView];
}
- (void)setupRightViewSubView:(UIView *)subView {
    [self.rightView addSubview:subView];
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightView);
        make.centerY.equalTo(self.rightView);
        make.width.equalTo(@(subView.width));
        make.height.equalTo(@(subView.height));
    }];
    [self setupUI];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupProperty];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setupUI];
        });
    }
    return self;
}

- (void)setupProperty {
    self.line.backgroundColor = [UIColor xxLineColor];
    self.line.hidden = self.lineHidden;
    
    self.leftTitleLabel.textColor = [UIColor xxTextColor333333];
    self.leftTitleLabel.font = [UIFont xxTextFont14];
    
    self.messageLabel.textColor = [UIColor xxTextColor666666];
    self.messageLabel.font = [UIFont xxTextFont14];
    self.messageLabel.textAlignment = NSTextAlignmentLeft;
    
    self.textField.textColor = [UIColor xxTextColor999999];
    self.textField.font = [UIFont xxTextFont14];
    self.textField.textAlignment = NSTextAlignmentRight;
    self.textField.hidden = YES;
}

- (void)setupUI {
    CGFloat rightViewWidth = self.rightView.subviews.count ? 50 : 0;
    if (self.accessoryType == XXButtonLikeCellAccessoryIndicator) {
        rightViewWidth = 10;
    }
    
    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(XXMarginFontLeft);
        make.centerY.equalTo(self);
        make.height.equalTo(self);
    }];
    [self.rightView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(XXMarginFontRight);
        make.centerY.equalTo(self);
        make.height.equalTo(self);
        make.width.equalTo(@(rightViewWidth));
    }];
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(90);
        make.centerY.equalTo(self);
        make.height.equalTo(self);
        make.right.equalTo(self.rightView.mas_left).offset(-2);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(XXMarginFontLeft);
        make.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageLabel);
        make.right.equalTo(self.messageLabel);
        make.top.equalTo(self.messageLabel);
        make.bottom.equalTo(self.messageLabel);
    }];
}

XXLazyLabel(self, leftTitleLabel)
XXLazyLabel(self, messageLabel)
XXLazyView(self, rightView)
XXLazyView(self, line)

XXLazyTextField(self, textField)


@end

