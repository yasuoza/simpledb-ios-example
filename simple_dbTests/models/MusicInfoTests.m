#import <XCTest/XCTest.h>
#import "MusicInfo.h"

@interface MusicInfoTests : XCTestCase

@property MusicInfo *musicInfo;

@end

@implementation MusicInfoTests

- (void)setUp {
    [super setUp];

    _musicInfo = [[MusicInfo alloc] init];
    _musicInfo.scorePath = @"___---___---";
    _musicInfo.musicName = @"hello world";
    _musicInfo.shareDate = 100000;
}

- (void)tearDown {
    [super tearDown];

    // Clean up dummy record
    XCTAssert([_musicInfo destroy], @"destroy should success");
}

# pragma mark - Setter and Getter

- (void)testSetGetMusicName {
    MusicInfo *musicInfo = [[MusicInfo alloc] init];
    XCTAssertNil(musicInfo.musicName, @"musicName should be nil");
    musicInfo.musicName = @"hello world";
    XCTAssertNotNil(musicInfo.musicName, @"musicName should not be nil");
    XCTAssert([musicInfo.musicName isEqualToString:@"hello world"], @"setter and getter should work");
}

- (void)testSetGetOrgMusicName {
    MusicInfo *musicInfo = [[MusicInfo alloc] init];
    XCTAssertNil(musicInfo.orgMusicName, @"orgMusicName should be nil");
    musicInfo.orgMusicName = @"hello world";
    XCTAssertNotNil(musicInfo.orgMusicName, @"orgMusicName should not be nil");
    XCTAssert([musicInfo.orgMusicName isEqualToString:@"hello world"], @"setter and getter should work");
}

- (void)testSetGetUserName {
    MusicInfo *musicInfo = [[MusicInfo alloc] init];
    XCTAssertNil(musicInfo.userName, @"userName should be nil");
    musicInfo.userName = @"hello world";
    XCTAssertNotNil(musicInfo.userName, @"userName should not be nil");
    XCTAssert([musicInfo.userName isEqualToString:@"hello world"], @"setter and getter should work");
}

- (void)testSetGetOrgUserName {
    MusicInfo *musicInfo = [[MusicInfo alloc] init];
    XCTAssertNil(musicInfo.orgUserName, @"orgUserName should be nil");
    musicInfo.orgUserName = @"hello world";
    XCTAssertNotNil(musicInfo.orgUserName, @"orgUserName should not be nil");
    XCTAssert([musicInfo.orgUserName isEqualToString:@"hello world"], @"setter and getter should work");
}

- (void)testSetGetScorePath {
    MusicInfo *musicInfo = [[MusicInfo alloc] init];
    XCTAssertNil(musicInfo.scorePath, @"scorePath should be nil");
    musicInfo.scorePath = @"hello world";
    XCTAssertNotNil(musicInfo.scorePath, @"scorePath should not be nil");
    XCTAssert([musicInfo.scorePath isEqualToString:@"hello world"], @"setter and getter should work");
}

- (void)testSetGetDeviceId {
    MusicInfo *musicInfo = [[MusicInfo alloc] init];
    XCTAssertNil(musicInfo.deviceId, @"deviceId should be nil");
    musicInfo.deviceId = @"hello world";
    XCTAssertNotNil(musicInfo.deviceId, @"deviceId should not be nil");
    XCTAssert([musicInfo.deviceId isEqualToString:@"hello world"], @"setter and getter should work");
}

- (void)testSetGetOrgDeviceId {
    MusicInfo *musicInfo = [[MusicInfo alloc] init];
    XCTAssertNil(musicInfo.orgDeviceId, @"orgDeviceId should be nil");
    musicInfo.orgDeviceId = @"hello world";
    XCTAssertNotNil(musicInfo.orgDeviceId, @"orgDeviceId should not be nil");
    XCTAssert([musicInfo.orgDeviceId isEqualToString:@"hello world"], @"setter and getter should work");
}

- (void)testSetGetShareDate {
    MusicInfo *musicInfo = [[MusicInfo alloc] init];
    XCTAssert(musicInfo.shareDate == 0, @"shareDate should be 0");
    musicInfo.shareDate = 1000;
    XCTAssert(musicInfo.shareDate == 1000, @"shareDate should be 1000");
}

- (void)testSetGetLength {
    MusicInfo *musicInfo = [[MusicInfo alloc] init];
    XCTAssert(musicInfo.length == 0, @"length should be 0");
    musicInfo.length = 1000;
    XCTAssert(musicInfo.length == 1000, @"length should be 1000");
}

- (void)testSetGetMusicType {
    MusicInfo *musicInfo = [[MusicInfo alloc] init];
    XCTAssert(musicInfo.musicType == 0, @"musicType should be 0");
    musicInfo.musicType = 1000;
    XCTAssert(musicInfo.musicType == 1000, @"musicType should be 1000");
}

# pragma mark - SimpleDB access tests

- (void)testFindByName {
    NSArray *musicInfos = [MusicInfo findByUserName:@"t-saito"];
    MusicInfo *musicInfo = musicInfos[0];
    XCTAssert([musicInfo.musicName isEqualToString:@"honyarara"],
              @"musicName should match");
    XCTAssert([musicInfo.scorePath isEqualToString:@"las/msc/w/201402/20140203203724_356778058592362.las"],
              @"scorePath should match");
    NSLog(@"musicInfo.description = %@", musicInfo.description);
}

- (void)testFindByMusicType {
    NSArray *musicInfos = [MusicInfo findByMusicType:1];
    XCTAssertNotNil(musicInfos, @"musicInfos should not to be nil");
    XCTAssert(musicInfos.count > 0, @"musicInfos.count should be more than 1");
}

- (void)testFindByMusicTypeWithLimit {
    NSArray *musicInfos = [MusicInfo findByMusicType:1 limit:3];
    XCTAssertNotNil(musicInfos, @"musicInfos should not to be nil");
    XCTAssert(musicInfos.count == 3, @"musicInfos.count should be more than 1");
}

- (void)testSaveNewRecord {
    XCTAssert([_musicInfo save], @"save should success");
}

- (void)testDeleteRecord {
    XCTAssert([_musicInfo save], @"save should success");
    XCTAssert([_musicInfo destroy], @"destroy should success");
}

@end
