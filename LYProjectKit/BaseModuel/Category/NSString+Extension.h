//
//  NSString+Extension.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/9/27.
//  Copyright © 2016年 gxz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <UIKit/UIKit.h>
@interface NSString (Extension)

- (NSString *)emoji;

- (CGSize)sizeWithMaxHeight:(CGFloat)height andFont:(UIFont *)font;
- (CGSize)sizeWithMaxWidth:(CGFloat)width andFont:(UIFont *)font;

- (NSString *)originName;

+ (NSString *)currentName;
+ (NSString *)getCurrenttimeWithdateFormat:(NSString *)dateformat;

- (NSString *)firstStringSeparatedByString:(NSString *)separeted;


- (BOOL)ET:(NSString *)string;

//按照yyyy-MM-dd'T'HH:mm:ssZZZZ格式转换日期字符串为yyyy-MM-dd HH:mm
+(NSString *) timeChange:(NSString *)timeString;

- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;//时间比较
+(int)compareDate:(NSString*)startDate withDate:(NSString*)endDate; //日期比较
-(NSString *)changeToMonthType;//处理时间格式，输入：yyyy-mm为参数；根据当前日期比较输出：10月，本月，或者2016年10月
-(NSString *) changeTime;

//+ (BOOL)isMobileNumber:(NSString *)mobileNum;统一成judgePhoneNumber

+(BOOL)isValidCertId:(NSString *)string;

//根据formatString格式转换日期返回yyy-MM-dd HH:mm
+(NSString *) timeChange:(NSString *)timeString format:(NSString *)formatString;

//获取两个时间字符串相差的天数
+ (NSInteger)getDifferenceByBeginDate:(NSString *)begindate endDate:(NSString *)endDate withFormat:(NSString *)format;

//判断是否银行卡
+ (BOOL) IsBankCard:(NSString *)cardNumber;

//换成两位小数
-(float)roundFloat;

- (BOOL)judgePhoneNumber;
- (BOOL)judgeIsBlank;
- (BOOL)judgePassWord;
//将数字变成红色
- (NSMutableAttributedString *)changeDigitNumberToRed;


//更改子字符
-(NSMutableAttributedString *)changeSubStr:(NSString *)subStr WithColor:(UIColor *)color;

//处理时间格式
- (NSString *)changeTimeModeWithType:(NSInteger)type;

-(NSString *)trimLeadingAndTraingBlank;//去头尾空格
+ (int)daysIntervalBetweenDateString:(NSString *)beginDate toDateString:(NSString *)endDate;


-(NSString *) aes256_encrypt:(NSString *)key;

-(NSString *) aes256_decrypt:(NSString *)key;

-(NSString *)utf8ToUnicode:(NSString *)string;

-(NSString *)replaceUnicode:(NSString *)unicodeStr;


@end
