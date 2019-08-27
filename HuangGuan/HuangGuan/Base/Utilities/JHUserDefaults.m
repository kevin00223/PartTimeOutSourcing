//
//  JHUserDefaults.m
//  Zfish
//
//  Created by Gerhard Z on 2018/11/19.
//  Copyright © 2018 Gerhard Z. All rights reserved.
//

#import "JHUserDefaults.h"
#import "HGAddressModel.h"

static JHUserDefaults *instance = nil;

NSString *const userDefaultUidKey = @"uid";
NSString *const userDefaultAccessTokenKey = @"access_token";
NSString *const userDefaultRefreshTokenKey = @"refresh_token";
NSString *const userDefaultExpiresInKey = @"expires_in";
NSString *const userDefaultMobileKey = @"contact";
NSString *const userDefaultNameKey = @"name";
NSString *const userDefaultAvatarUrlKey = @"avatarUrl";
NSString *const userDefaultEmailKey = @"email";
NSString *const userDefaultAuthoritiesKey = @"authorities";

@implementation JHUserDefaults

+ (JHUserDefaults *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSNumber *)uid {
    return [UserDefault objectForKey:userDefaultUidKey];
}

- (NSString *)access_token {
    return [UserDefault objectForKey:userDefaultAccessTokenKey];
}

- (NSString *)refresh_token {
    return [UserDefault objectForKey:userDefaultRefreshTokenKey];
}

- (NSNumber *)expires_in {
    return [UserDefault objectForKey:userDefaultExpiresInKey];
}

- (NSString *)avatarUrl {
    return [UserDefault objectForKey:userDefaultAvatarUrlKey];
}

- (NSString *)email {
    return [UserDefault objectForKey:userDefaultEmailKey];
}

- (NSString *)mobile {
    return [UserDefault objectForKey:userDefaultMobileKey];
}

-(NSString *)name {
    return [UserDefault objectForKey:userDefaultNameKey];
}

- (NSArray *)authorities {
    return [UserDefault objectForKey:userDefaultAuthoritiesKey];
}

//存储登录信息
- (void)setLoginMemberUid:(NSNumber *)uid accessToken:(NSString *)ac_token refreshToken:(NSString *)re_token
             andExpiresIn:(NSNumber *)expires_in {
    
    [self changeValueForKey:userDefaultAccessTokenKey withValue:ac_token];
    [self changeValueForKey:userDefaultRefreshTokenKey withValue:re_token];
    [self changeValueForKey:userDefaultExpiresInKey withValue:expires_in];
    [self changeValueForKey:userDefaultUidKey withValue:uid];

}

- (void)changeValueForKey:(NSString *)key withValue:(id)object {
    [self willChangeValueForKey:key];
    [UserDefault setObject:object forKey:key];
    [self didChangeValueForKey:key];
}

- (void)removeObjectForKey:(NSString *)key {
    [self willChangeValueForKey:key];
    [UserDefault removeObjectForKey:key];
    [self didChangeValueForKey:key];
    [UserDefault synchronize];
}

- (void)setMemberInfoName:(NSString *)name email:(NSString *_Nullable)email mobile:(NSString *)mobile authorities:(NSArray *)authorities  andAvatarUrl:(NSString *_Nullable)url{
    [self changeValueForKey:userDefaultNameKey withValue:name];
    [self changeValueForKey:userDefaultMobileKey withValue:mobile];
    [self changeValueForKey:userDefaultEmailKey withValue:email];
    [self changeValueForKey:userDefaultAuthoritiesKey withValue:authorities];
    [self changeValueForKey:userDefaultAvatarUrlKey withValue:url];
}

- (void)resetMobile:(NSString *)mobile {
    [self changeValueForKey:userDefaultMobileKey withValue:mobile];
}

- (void)changeAvatar:(NSString *)avatarUrl {
    [self changeValueForKey:userDefaultAvatarUrlKey withValue:avatarUrl];
}

- (void)updateMember:(NSString *)name {
    [self changeValueForKey:userDefaultNameKey withValue:name];
}

- (void)loginOut {
    [self removeObjectForKey:userDefaultNameKey];
    [self removeObjectForKey:userDefaultMobileKey];
    [self removeObjectForKey:userDefaultEmailKey];
    [self removeObjectForKey:userDefaultAvatarUrlKey];
    [self removeObjectForKey:userDefaultUidKey];
    [self removeObjectForKey:userDefaultExpiresInKey];
    [self removeObjectForKey:userDefaultAccessTokenKey];
    [self removeObjectForKey:userDefaultRefreshTokenKey];
    [self removeObjectForKey:userDefaultAuthoritiesKey];
    
    [HGAddressModel bg_drop:@"addressDB"];
    [HGAddressModel bg_drop:@"orderDB"];
}





@end
