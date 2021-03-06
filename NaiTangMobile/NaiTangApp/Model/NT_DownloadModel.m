
//
//  NT_DownloadModel.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
#import <mach/mach_time.h>

#import "NT_DownloadModel.h"

@implementation NT_DownloadModel

- (id)initWithAddress:(NSString *)downAddress andGameName:(NSString *)gameName andRoundPic:(NSString *)roundPic andVersion:(NSString *)version  andAppID:(NSString *)appID
{
    if (self = [super init]) {
        self.addressName = downAddress;
        self.gameName = gameName;
        self.saveName = [gameName md5];
        self.iconName = roundPic;
        self.savePath = [NSString stringWithFormat:@"%@/Library/Caches/%@.ipa",NSHomeDirectory(),self.saveName];
        
        self.progress = 0.0f;
        self.loadType = LOADING;
        self.buttonStatus = pauseOn;
        self.isChecked = NO;
        self.priority = 0;
        self.operation = nil;
        self.appID = appID;
        self.version = version;
        self.modelID = mach_absolute_time();
        self.pausedByNetworkChange = false;
        self.autoRetryTimes=0;
        self.isAutoRetry = false;
    }
    return self;
}



- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.addressName forKey:@"DownLoadModelAddressName"];
    [aCoder encodeObject:self.gameName forKey:@"DownLoadModelGameName"];
    [aCoder encodeObject:self.iconName forKey:@"DownLoadModelIconName"];
    [aCoder encodeObject:self.savePath forKey:@"DownLoadModelSavePath"];
    [aCoder encodeObject:self.package forKey:@"DownLoadModelPackage"];
    [aCoder encodeObject:self.saveName forKey:@"DownLoadModelSaveName"];
    
    [aCoder encodeInt64:self.fileSize forKey:@"DownLoadModelFileSize"];
    [aCoder encodeFloat:self.progress forKey:@"DownLoadModelProgress"];
    [aCoder encodeInt:self.loadType forKey:@"DownLoadModelLoadType"];
    [aCoder encodeBool:self.isChecked forKey:@"DownLoadModelIsChecked"];
    [aCoder encodeBool:self.isUpdateModel forKey:@"DownLoadModelIsUpdateModel"];
    [aCoder encodeInt:self.priority forKey:@"DownLoadModelPriority"];
    [aCoder encodeObject:self.appID forKey:@"DownLoadModelNaitangID"];
    [aCoder encodeObject:self.version forKey:@"DownLoadModelVersion"];
    [aCoder encodeObject:self.savePlistPath forKey:@"DownLoadModelSavePlistPath"];
    [aCoder encodeInt:self.buttonStatus forKey:@"DownLoadModelButtonStatus"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self.addressName = [aDecoder decodeObjectForKey:@"DownLoadModelAddressName"];
    self.gameName = [aDecoder decodeObjectForKey:@"DownLoadModelGameName"];
    self.iconName = [aDecoder decodeObjectForKey:@"DownLoadModelIconName"];
    self.savePath = [aDecoder decodeObjectForKey:@"DownLoadModelSavePath"];
    self.package = [aDecoder decodeObjectForKey:@"DownLoadModelPackage"];
    self.saveName = [aDecoder decodeObjectForKey:@"DownLoadModelSaveName"];
    
    self.fileSize = [aDecoder decodeInt64ForKey:@"DownLoadModelFileSize"];
    self.progress = [aDecoder decodeFloatForKey:@"DownLoadModelProgress"];
    self.loadType = [aDecoder decodeIntForKey:@"DownLoadModelLoadType"];
    self.isChecked = [aDecoder decodeBoolForKey:@"DownLoadModelIsChecked"];
    self.isUpdateModel = [aDecoder decodeBoolForKey:@"DownLoadModelIsUpdateModel"];
    self.priority = [aDecoder decodeIntForKey:@"DownLoadModelPriority"];
    self.appID = [aDecoder decodeObjectForKey:@"DownLoadModelNaitangID"];
    self.version = [aDecoder decodeObjectForKey:@"DownLoadModelVersion"];
    self.savePlistPath = [aDecoder decodeObjectForKey:@"DownLoadModelSavePlistPath"];
    self.buttonStatus = [aDecoder decodeIntForKey:@"DownLoadModelButtonStatus"];
    self.modelID = mach_absolute_time();
    self.pausedByNetworkChange = false;
    self.autoRetryTimes=0;
    self.isAutoRetry = false;
    return self;
}

@end
