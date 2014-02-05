#import "MusicInfo.h"
#import "Constants.h"
#import <AWSRuntime/AWSRuntime.h>
#import <AWSSimpleDB/AWSSimpleDB.h>

static AmazonSimpleDBClient *__sdbClient;
const static NSString *domain = @"MusicInfo";


@interface MusicInfo()

@property (strong, nonatomic) NSMutableDictionary *attributes;

@end

@implementation MusicInfo

+ (AmazonSimpleDBClient *)dbClient {
    if (!__sdbClient) {
        // Initial the SimpleDB Client.
        __sdbClient      = [[AmazonSimpleDBClient alloc] initWithAccessKey:ACCESS_KEY_ID withSecretKey:SECRET_KEY];
        __sdbClient.endpoint = [AmazonEndpoints sdbEndpoint:AP_NORTHEAST_1];
    }
    return __sdbClient;
}

+ (NSArray *)where:(NSString *)query {
    NSString *fullQuery = [NSString stringWithFormat:@"SELECT * FROM `%@` WHERE %@",
                           domain, query];

    SimpleDBSelectRequest *selectRequest = [[SimpleDBSelectRequest alloc] initWithSelectExpression:fullQuery];
    selectRequest.consistentRead = YES;

    SimpleDBSelectResponse *selectResponse = [self.dbClient select:selectRequest];
    if(selectResponse.error != nil) {
        NSLog(@"Error: %@", selectResponse.error);
        return nil;
    }

    NSMutableArray *musicItems = [[NSMutableArray alloc] initWithCapacity:0];
    for (SimpleDBItem *dbItem in selectResponse.items) {
        [musicItems addObject:[[MusicInfo alloc] initWithDBAttributes:dbItem.attributes]];
    }

    return musicItems;
}

+ (NSArray *)findByUserName:(NSString *)userName {
    return [self where:[NSString stringWithFormat:@"`userName` = '%@'", userName]];
}

+ (NSArray *)findByMusicType:(NSInteger)musicType {
    return [self where:[NSString stringWithFormat:@"`musicType` = '%d' AND `shareDate` IS NOT NULL ORDER BY `shareDate`", musicType]];
}

+ (NSArray *)findByMusicType:(NSInteger)musicType limit:(NSInteger)limit {
    return [self where:[NSString stringWithFormat:@"`musicType` = '%d' AND `shareDate` IS NOT NULL ORDER BY `shareDate` LIMIT %d", musicType, limit]];
}


# pragma mark - Instance methods

- (id)init {
    self = [super init];
    _attributes = [[NSMutableDictionary alloc] initWithCapacity:0];
    return self;
}

- (id)initWithDBAttributes:(NSArray *)attribute {
    self = [self init];

    for (SimpleDBAttribute *attr in attribute) {
        NSString *val = attr.value;

        /* If you want to keep NULL value to be nil, comment out following block. */
        // if (!val) {
        //     continue;
        // }

        _attributes[attr.name] = val ? val : [NSNull null];
    }

    return self;
}

- (NSString *)musicName {
    return _attributes[@"musicName"];
}

- (void)setMusicName:(NSString *)musicName {
    _attributes[@"musicName"] = musicName;
}

- (NSString *)orgMusicName {
    return _attributes[@"orgMusicName"];
}

- (void)setOrgMusicName:(NSString *)orgMusicName {
    _attributes[@"orgMusicName"] = orgMusicName;
}

- (NSString *)userName {
    return _attributes[@"userName"];
}

- (void)setUserName:(NSString *)userName {
    _attributes[@"userName"] = userName;
}

- (NSString *)orgUserName {
    return _attributes[@"orgUserName"];
}

- (void)setOrgUserName:(NSString *)orgUserName {
    _attributes[@"orgUserName"] = orgUserName;
}

- (NSString *)scorePath {
    return _attributes[@"scorePath"];
}

- (void)setScorePath:(NSString *)scorePath {
    _attributes[@"scorePath"] = scorePath;
}

- (NSString *)deviceId {
    return _attributes[@"deviceId"];
}
- (void)setDeviceId:(NSString *)deviceId {
    _attributes[@"deviceId"] = deviceId;
}

- (NSString *)orgDeviceId {
    return _attributes[@"orgDeviceId"];
}

- (void)setOrgDeviceId:(NSString *)orgDeviceId {
    _attributes[@"orgDeviceId"] = orgDeviceId;
}

- (NSInteger)shareDate {
    return [NSString stringWithFormat:@"%@", _attributes[@"shareDate"]].integerValue;
}

- (void)setShareDate:(NSInteger)shareDate {
    _attributes[@"shareDate"] = [NSString stringWithFormat:@"%d", shareDate];
}

- (NSInteger)length {
    return [NSString stringWithFormat:@"%@", _attributes[@"length"]].integerValue;
}

- (void)setLength:(NSInteger)length {
    _attributes[@"length"] = [NSString stringWithFormat:@"%d", length];
}

- (NSInteger)musicType {
    return [NSString stringWithFormat:@"%@", _attributes[@"musicType"]].integerValue;
}

- (void)setMusicType:(NSInteger)musicType {
    _attributes[@"musicType"] = [NSString stringWithFormat:@"%d", musicType];
}

- (NSString *)description {
    NSMutableString *attrStr = [[NSMutableString alloc] init];
    for (NSString *key in _attributes.keyEnumerator) {
        [attrStr appendString:[NSString stringWithFormat:@"\n%@ => %@", key, _attributes[key]]];
    }
    return attrStr;
}

@end
