//
//  NT_OnlineGameDialog.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_OnlineGameDialog.h"
#import <QuartzCore/QuartzCore.h>
#import "NT_BaseAppInfo.h"
#import "UIImageView+WebCache.h"
#import "NT_WifiBrowseImage.h"

@implementation NT_OnlineGameDialog

- (id)initWithFrame:(CGRect)frame appsInfo:(NT_AppDetailInfo *)appInfo
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _bgControl = [[UIControl alloc] initWithFrame:self.bounds];
        _bgControl.backgroundColor = [UIColor blackColor];
        _bgControl.alpha = 0.4;
        [_bgControl addTarget:self action:@selector(bgControlClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_bgControl];
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(40.0/800*SCREEN_WIDTH, 196.0/1279*SCREEN_HEIGHT, SCREEN_WIDTH-2*(40.0/800*SCREEN_WIDTH), 340)];
        _backView.backgroundColor = [UIColor colorWithHex:@"#f2f2f2"];
        _backView.userInteractionEnabled = YES;
        _backView.layer.cornerRadius = 15;
        _backView.clipsToBounds = YES;
        [self addSubview:_backView];
        
        _titTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 11, _backView.width-100, 25)];
        _titTextLabel.backgroundColor = [UIColor clearColor];
        _titTextLabel.text = @"去苹果官方App store";
        _titTextLabel.font = [UIFont systemFontOfSize:18];
        _titTextLabel.textAlignment = UITextAlignmentCenter;
        [_backView addSubview:_titTextLabel];
        
        UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(_backView.width-40, 15, 20, 20)];
        [delBtn addTarget:self action:@selector(delBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [delBtn setBackgroundImage:[UIImage imageNamed:@"close-x.png"] forState:UIControlStateNormal];
        //        [delBtn setImage:[UIImage imageNamed:@"设置退出x.png"] forState:UIControlStateNormal];
        delBtn.backgroundColor = [UIColor clearColor];
        [_backView addSubview:delBtn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45, _backView.width, 1.5)];
        line.backgroundColor = COLOR_WITH_RGB(121, 192, 240);
        [_backView addSubview:line];
        self.lineView = line;
        
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(_backView.width - 40, 0, 60, 60)];
        [control addTarget:self action:@selector(delBtnClick:)  forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:control];
        
        _roundView = [[UIImageView alloc] initWithFrame:CGRectMake(35, line.bottom+20, _backView.width-70, 220*0.44)];
        _roundView.backgroundColor = [UIColor clearColor];
        _roundView.image = [UIImage imageNamed:@"line-dashed.png"];
        [_backView addSubview:_roundView];
        
        //_iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(30*0.4, 30*0.44, 160*0.4, 160*0.4)];
        _iconImgView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"default-icon.png"]];
        _iconImgView.frame = CGRectMake(30*0.4, 30*0.44, 160*0.4, 160*0.4);
        _iconImgView.layer.cornerRadius = 12;
        _iconImgView.clipsToBounds = YES;
        _iconImgView.backgroundColor = [UIColor blackColor];
        //若有缓存，使用缓存图片显示
        [_iconImgView imageUrl:[NSURL URLWithString:appInfo.round_pic] tempSTR:@"false"];
        /*
        NT_WifiBrowseImage *wifiImage = [[NT_WifiBrowseImage alloc] init];
        [wifiImage wifiBrowseImage:_iconImgView urlString:appInfo.round_pic];
         */
        //[_iconImgView setImageWithURL:[NSURL URLWithString:appInfo.round_pic]];
        [_roundView addSubview:_iconImgView];
        
        _appNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconImgView.right+20*0.4, _iconImgView.top, self.roundView.width-(_iconImgView.right+20*0.4)-5, 25)];
        _appNameLabel.backgroundColor = [UIColor clearColor];
        _appNameLabel.font = [UIFont systemFontOfSize:14];
        _appNameLabel.text = appInfo.game_name;
        [_roundView addSubview:_appNameLabel];
        
        //_scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(_appNameLabel.left, _appNameLabel.bottom, 25, 15)];
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(_appNameLabel.left, _appNameLabel.bottom, 35, 15)];
        _scoreLabel.backgroundColor = [UIColor clearColor];
        _scoreLabel.font = [UIFont systemFontOfSize:12];
        _scoreLabel.textColor = COLOR_WITH_RGB(37, 122, 204);
        _scoreLabel.text = [NSString stringWithFormat:@"%@分",appInfo.score];
        [_roundView addSubview:_scoreLabel];
        
        _sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_scoreLabel.right+20*0.4, _appNameLabel.bottom, 50, 15)];
        _sizeLabel.backgroundColor = [UIColor clearColor];
        _sizeLabel.font = [UIFont systemFontOfSize:12];
        _sizeLabel.textColor = COLOR_WITH_RGB(153, 153, 153);
        _sizeLabel.text = appInfo.size;
        [_roundView addSubview:_sizeLabel];
        
        _versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(_sizeLabel.right+20*0.2, _appNameLabel.bottom, 45, 15)];
        _versionLabel.backgroundColor = [UIColor clearColor];
        _versionLabel.font = [UIFont systemFontOfSize:12];
        _versionLabel.textColor = COLOR_WITH_RGB(153, 153, 153);
        _versionLabel.text = [NSString stringWithFormat:@"%@版",appInfo.app_version_name];
        [_roundView addSubview:_versionLabel];
        
        UIImageView *moneyView = [[UIImageView alloc] initWithFrame:CGRectMake(_iconImgView.right+20*0.4, _scoreLabel.bottom+5, 40, 20)];
        moneyView.layer.cornerRadius = 10;
        moneyView.clipsToBounds = YES;
        moneyView.backgroundColor = COLOR_WITH_RGB(246, 102, 3);
        [_roundView addSubview:moneyView];
        
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectInset(moneyView.bounds, 4, 0)];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.backgroundColor = [UIColor clearColor];
        _moneyLabel.font = [UIFont systemFontOfSize:12];
        _moneyLabel.textAlignment = UITextAlignmentCenter;
        _moneyLabel.text = [appInfo.fee intValue]==0?@"免费":[NSString stringWithFormat:@"$%@",appInfo.fee];
        [moneyView addSubview:_moneyLabel];
        
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clickBtn.frame = CGRectMake(self.roundView.left, _roundView.bottom+20, self.roundView.width, 30);
        clickBtn.layer.cornerRadius = clickBtn.height/2;
        //[clickBtn addTarget:self action:@selector(clickBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [clickBtn addTarget:self action:@selector(backBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [clickBtn setTitle:@"使用奶糖账号免费下载" forState:UIControlStateNormal];
        [clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        clickBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [clickBtn setBackgroundImage:[UIImage imageNamed:@"btn-confirm.png"] forState:UIControlStateNormal];
        [clickBtn setBackgroundImage:[UIImage imageNamed:@"btn-confirm-hover.png"] forState:UIControlStateHighlighted];
        [_backView addSubview:clickBtn];
        self.ntDownBtn = clickBtn;
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(self.roundView.left, clickBtn.bottom+30*0.44, self.roundView.width, 30);
        backBtn.layer.cornerRadius = backBtn.height/2;
        [backBtn addTarget:self action:@selector(backBtnCLick:) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setTitle:@"NO,用自己苹果账号" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"btn-confirm.png"] forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"btn-confirm-hover.png"] forState:UIControlStateHighlighted];
        [_backView addSubview:backBtn];
        self.appStoreDownBtn = backBtn;
        
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(backBtn.left, backBtn.bottom+3  , backBtn.width, 40)];
        descLabel.numberOfLines = 0;
        descLabel.backgroundColor = [UIColor clearColor];
        descLabel.font = [UIFont systemFontOfSize:10];
        descLabel.textColor = [UIColor colorWithHex:@"#ff6600"];
        descLabel.text = @"小贴士：您将要安装的是网络游戏，只有使用自己的账号才可以在游戏内消费。";
        [_backView addSubview:descLabel];
    }
    return self;
}

- (void)backBtnCLick:(UIButton *)btn
{
    [self removeDialog];
}

- (void)delBtnClick:(UIButton *)btn
{
    [self removeDialog];
}

- (void)bgControlClick:(UIColor *)control
{
    [self removeDialog];
}

- (void)removeDialog
{
    self.hidden = YES;
    [self removeFromSuperview];
}

- (void)dealloc
{
    self.bgControl = nil;
    self.lineView = nil;
    self.backView = nil;
    self.titTextLabel = nil;
    self.appNameLabel = nil;
    self.scoreLabel = nil;
    self.sizeLabel = nil;
    self.versionLabel = nil;
    self.moneyLabel = nil;
    self.roundView = nil;
    self.iconImgView = nil;
    self.ntDownBtn = nil;
    self.appStoreDownBtn = nil;
}

@end
