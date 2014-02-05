#import <Foundation/Foundation.h>

@interface MusicInfo : NSObject

+ (NSArray *)where:(NSString *)query;
+ (NSArray *)findByUserName:(NSString *)userName;
+ (NSArray *)findByMusicType:(NSInteger)musicType;
+ (NSArray *)findByMusicType:(NSInteger)musicType limit:(NSInteger)limit;


- (NSString *)musicName;
- (void)setMusicName:(NSString *)musicName;

- (NSString *)orgMusicName;
- (void)setOrgMusicName:(NSString *)orgMusicName;

- (NSString *)userName;
- (void)setUserName:(NSString *)userName;

- (NSString *)orgUserName;
- (void)setOrgUserName:(NSString *)orgUserName;

- (NSString *)scorePath;
- (void)setScorePath:(NSString *)scorePath;

- (NSString *)deviceId;
- (void)setDeviceId:(NSString *)deviceId;

- (NSString *)orgDeviceId;
- (void)setOrgDeviceId:(NSString *)orgDeviceId;

- (NSInteger)shareDate;
- (void)setShareDate:(NSInteger)shareDate;

- (NSInteger)length;
- (void)setLength:(NSInteger)length;

- (NSInteger)musicType;
- (void)setMusicType:(NSInteger)musicType;

- (BOOL)save;

@end
