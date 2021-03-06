//
//  NT_DetailIntroView.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-7.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  详情-游戏介绍

#import <UIKit/UIKit.h>
#import "NT_IntroduceInfo.h"
#import "RTLabel.h"

#define KIntroCellHeight 240

@class NT_BaseAppDetailInfo;
@protocol NT_DetailIntroViewDelegate;

@interface NT_DetailIntroView : UIView

@property (nonatomic,strong) NT_IntroduceInfo *introInfo;
@property (nonatomic,strong) UILabel *jreLabel,*categoryLabel,*sizeLabel, *languageLabel,*devLabel,*detailLabel;
@property (nonatomic,strong) UIButton *expansionButton;
@property (nonatomic,assign) BOOL isExpansion;
@property (nonatomic,weak) id <NT_DetailIntroViewDelegate> delegate;
@property (nonatomic, strong)  UIView *infoView ;

//加载游戏介绍信息
- (void)refreshIntroData:(NT_BaseAppDetailInfo *)detailInfo isExpansion:(BOOL)flag;

@end

//展开游戏介绍
@protocol NT_DetailIntroViewDelegate <NSObject>

- (void)expansionDetailInfoViewDelegate:(CGFloat)height expansion:(BOOL)flag;

@end
