//
//  JHUserDefaults.h
//  Zfish
//
//  Created by Gerhard Z on 2018/11/19.
//  Copyright © 2018 Gerhard Z. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString *const userDefaultUidKey;
extern NSString *const userDefaultAccessTokenKey;
extern NSString *const userDefaultRefreshTokenKey;
extern NSString *const userDefaultExpiresInKey;
extern NSString *const userDefaultMobileKey;
extern NSString *const userDefaultNameKey;
extern NSString *const userDefaultAvatarUrlKey;
extern NSString *const userDefaultEmailKey;
extern NSString *const userDefaultAuthoritiesKey;
@interface JHUserDefaults : NSObject

//登录信息
@property (nonatomic, copy, readonly) NSString *access_token;

@property (nonatomic, copy, readonly) NSString *refresh_token;

@property (nonatomic, copy, readonly) NSNumber *uid;

@property (nonatomic, copy, readonly) NSNumber *expires_in;


//个人信息
@property (nonatomic, copy, readonly) NSString *avatarUrl;

@property (nonatomic, copy, readonly,nullable) NSString *email;

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSString *mobile;

@property (nonatomic, strong, readonly) NSArray *authorities;

+ (JHUserDefaults *)shareInstance;

- (void)setLoginMemberUid:(NSNumber *)uid accessToken:(NSString *)ac_token refreshToken:(NSString *)re_token
             andExpiresIn:(NSNumber *)expires_in;

- (void)setMemberInfoName:(NSString *)name email:(NSString *_Nullable)email mobile:(NSString *)mobile authorities:(NSArray *)authorities  andAvatarUrl:(NSString *_Nullable)url;

- (void)loginOut;

- (void)resetMobile:(NSString *)mobile;

- (void)updateMember:(NSString *_Nullable)name;

- (void)changeAvatar:(NSString *)avatarUrl;
@end

NS_ASSUME_NONNULL_END
