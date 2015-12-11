//
//  Test_XYJSON.m
//  JoinShow
//
//  Created by Heaven on 15/11/24.
//  Copyright © 2015年 Heaven. All rights reserved.
//

#import "XYQuick.h"

#pragma mark -
// ----------------------------------
// Unit test
// ----------------------------------
#if (1 == __XY_DEBUG_UNITTESTING__)

uxy_as_JSONAutoParse(Address999)

uxy_as_JSONAutoParse(Asdasasdad)

uxy_as_JSONAutoParse(Country)


@interface Country : NSObject <Country>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *name_id;
@end

@implementation Country
@end

@interface Country2 : NSObject <XYJSON>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger num;
@end

@implementation Country2
@end

uxy_as_JSONAutoParse(Address)

@interface Address : NSObject <Address, Address999, Asdasasdad>
@property (nonatomic, assign) int code;
@property (nonatomic, strong) Country <Country> *country;
@property (nonatomic, copy) NSString *area;
@end

@implementation Address
@end




@interface Address2 : NSObject
@property (nonatomic, assign) int code;
@property (nonatomic, strong) Country <Country> *country;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *string;
@end

@implementation Address2
@end


@interface Tour : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray <Address999, Address> *list;
@end

@implementation Tour
@end


@interface Tour2 : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray <Address> *list;

@end

@implementation Tour2
+ (void)initialize
{
    if (self == [Tour2 class]){
        [self uxy_addNickname:@"name2" forProperty:@"name"];
        [self uxy_addNickname:@"name4" forProperty:@"name"];
        [self uxy_addNickname:@"list2" forProperty:@"list"];
    }
}
@end

UXY_TEST_CASE( Core, JSON )
{
    //	TODO( "test case" )
}

UXY_DESCRIBE( test0 )
{
    // 普通的解析
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json0.json" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    if (str.length == 0)
        return;
    
    Address *address = [str uxy_JSONObjectByClass:[Address class]];
    UXY_EXPECTED( address.code == 1 );
    UXY_EXPECTED( [address.area isEqualToString:@"华东"] );
    UXY_EXPECTED( [address.country.name isEqualToString:@"天朝"] );
}

UXY_DESCRIBE( test0_1 )
{
    // 变量里有多余的属性
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json0.json" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    if (str.length == 0)
        return;
    
    Address2 *address = [str uxy_JSONObjectByClass:[Address2 class]];
    UXY_EXPECTED( address.code == 1 );
    UXY_EXPECTED( address.string.length == 0 );
    UXY_EXPECTED( [address.area isEqualToString:@"华东"] );
    UXY_EXPECTED( [address.country.name isEqualToString:@"天朝"] );
}

UXY_DESCRIBE( test1 )
{
    // 解析成字典
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json1.json" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    if (str.length == 0)
        return;
    
    NSDictionary *dic = [str uxy_JSONObject];
    UXY_EXPECTED( dic.count == 3 );
}

UXY_DESCRIBE( test2 )
{
    // 解析某个key里的值
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json2.json" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    if (str.length == 0)
        return;
    
    Address *address = [str uxy_JSONObjectByClass:[Address class] forKeyPath:@"data"];
    UXY_EXPECTED( address.code == 1 );
    UXY_EXPECTED( [address.area isEqualToString:@"华东"] );
    UXY_EXPECTED( [address.country.name isEqualToString:@"天朝"] );
}

UXY_DESCRIBE( test2_1 )
{
    // keyPath
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json2.json" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    if (str.length == 0)
        return;
    
    Country *country = [str uxy_JSONObjectByClass:[Country class] forKeyPath:@"data.country"];
    UXY_EXPECTED( [country.name isEqualToString:@"天朝"] );
}

UXY_DESCRIBE( test2_2 )
{
    // key带有count
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json2_2.json" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    if (str.length == 0)
        return;
    
    Address *address = [str uxy_JSONObjectByClass:[Address class] forKeyPath:@"count"];
    UXY_EXPECTED( address.code == 1 );
    UXY_EXPECTED( [address.area isEqualToString:@"华东"] );
    UXY_EXPECTED( [address.country.name isEqualToString:@"天朝"] );
}

UXY_DESCRIBE( test3 )
{
    // 属性带有NSArray
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json3.json" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    if (str.length == 0)
        return;
    
    Tour *tour = [str uxy_JSONObjectByClass:[Tour class]];
    UXY_EXPECTED( [tour.name isEqualToString:@"线路"] );
    
    Address *address = tour.list[0];
    UXY_EXPECTED( address.code == 1 );
    UXY_EXPECTED( [address.area isEqualToString:@"华东"] );
    UXY_EXPECTED( [address.country.name isEqualToString:@"天朝"] );
}

UXY_DESCRIBE( test4 )
{
    // 解析 NSArray
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json4.json" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    if (str.length == 0)
        return;
    
    NSArray *array = [str uxy_JSONObjectByClass:[Address class]];
    Address *address = array[0];
    
    UXY_EXPECTED( address.code == 1 );
    UXY_EXPECTED( [address.area isEqualToString:@"华东"] );
    UXY_EXPECTED( [address.country.name isEqualToString:@"天朝"] );
}

UXY_DESCRIBE( test5 )
{
    // 开启JSONCache 提高一个返回值里有多个对象的时候解析速度的问题.
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json5.json" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    str.uxy_keepJSONObjectCache = YES;
    if (str.length == 0)
        return;
    
    Address *address = [str uxy_JSONObjectByClass:[Address class] forKeyPath:@"data1"][0];
    Country *country = [str uxy_JSONObjectByClass:[Country class] forKeyPath:@"data2"];
    
    UXY_EXPECTED( [address.country.name isEqualToString:@"天朝"] );
    UXY_EXPECTED( [country.name isEqualToString:@"米国"] );
}

UXY_DESCRIBE( test6 )
{
    // 有空值
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json6.json" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    if (str.length == 0)
        return;
    
    Tour *tour = [str uxy_JSONObjectByClass:[Tour class]];
    UXY_EXPECTED( [tour.name isEqualToString:@"线路"] );
    UXY_EXPECTED( tour.list == nil );
}

UXY_DESCRIBE( test7 )
{
    // key的名字和属性不一致
    NSString *str = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"json7.json" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    if (str.length == 0)
        return;
    
    Tour2 *tour = [str uxy_JSONObjectByClass:[Tour2 class]];
    UXY_EXPECTED( [tour.name isEqualToString:@"线路"] );
    
    Address *address = tour.list[0];
    UXY_EXPECTED( address.code == 1 );
    UXY_EXPECTED( [address.area isEqualToString:@"华东"] );
    UXY_EXPECTED( [address.country.name isEqualToString:@"天朝"] );
}


UXY_DESCRIBE(test8_0)
{
    // 对象解析成字串
    Country2 *country = [[Country2 alloc] init];
    country.name = @"米国";
    country.num = 100;
    
    NSString *str = [country uxy_JSONString];
    NSDictionary *dic = [str uxy_JSONObject];
    NSInteger i = [(NSNumber *)dic[@"num"] integerValue];
    
    UXY_EXPECTED( [dic[@"name"] isEqualToString:@"米国"] );
    UXY_EXPECTED( i == 100 );
}

UXY_DESCRIBE(test9)
{
    // 对象解析成字典
    Country2 *country = [[Country2 alloc] init];
    country.name = @"米国";
    country.num = 100;
    
    NSDictionary *dic = [country uxy_JSONDictionary];
    NSInteger i = [(NSNumber *)dic[@"num"] integerValue];
    
    UXY_EXPECTED( [dic[@"name"] isEqualToString:@"米国"] );
    UXY_EXPECTED( i == 100 );
}

UXY_TEST_CASE_END

#endif