//
//  NSString+Extension.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/9/27.
//  Copyright © 2016年 gxz. All rights reserved.
//

#import "NSString+Extension.h"
#import "NSData+AES.h"
#import <CommonCrypto/CommonCrypto.h>
#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)

@implementation NSString (Extension)

- (NSString *)emoji
{
    return [NSString emojiWithStringCode:self];
}

+ (NSString *)emojiWithStringCode:(NSString *)stringCode
{
    char *charCode = (char *)stringCode.UTF8String;
    long intCode = strtol(charCode, NULL, 16);
    return [self emojiWithIntCode:(int)intCode];
}

+ (NSString *)emojiWithIntCode:(int)intCode {
    int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

- (CGSize)sizeWithMaxWidth:(CGFloat)width andFont:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    NSDictionary *dict = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

- (CGSize)sizeWithMaxHeight:(CGFloat)height andFont:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(MAXFLOAT,height);
    NSDictionary *dict = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
}

- (NSString *)originName
{
    NSArray *list = [self componentsSeparatedByString:@"_"];
    NSMutableString *orgName = [NSMutableString string];
    NSUInteger count = list.count;
    if (list.count > 1) {
        for (int i = 1; i < count; i ++) {
            [orgName appendString:list[i]];
            if (i < count-1) {
                [orgName appendString:@"_"];
            }
        }
    } else {  // 防越狱的情况下，本地改名字
        orgName = list[0];
    }
    return orgName;
}

+ (NSString *)currentName
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYYMMddHHMMss"];
    NSString *currentDate = [dateFormatter stringFromDate:[NSDate date]];
    return currentDate;
}

//YYYY-MM-dd hh:mm:ss...
+ (NSString *)getCurrenttimeWithdateFormat:(NSString *)dateformat{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:dateformat];
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}

- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

//比较两个日期大小
+(int)compareDate:(NSString*)startDate withDate:(NSString*)endDate{
    if (startDate.length != endDate.length) {
        NSLog(@"日期格式不相同");
    }
    int comparisonResult;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //区分不同格式的时间比较，以后仍然需要继续延展，至具体的日，时秒--》或者直接按照秒来比较
    if ([startDate containsString:@"-"]) {
        switch (startDate.length) {
            case 4:
                [formatter setDateFormat:@"yyyy"];
                break;
            case 7:
                [formatter setDateFormat:@"yyyy-MM"];
                break;
            case 10:
                [formatter setDateFormat:@"yyyy-MM-dd"];
                break;
                
            default:
                break;
        }
    }else{
        [formatter setDateFormat:@"yyyy"];
    }

    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] init];
    date1 = [formatter dateFromString:startDate];
    date2 = [formatter dateFromString:endDate];
    NSComparisonResult result = [date1 compare:date2];
    NSLog(@"result==%ld",(long)result);
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending:
            comparisonResult = 1;
            break;
            //date02比date01小
        case NSOrderedDescending:
            comparisonResult = -1;
            break;
            //date02=date01
        case NSOrderedSame:
            comparisonResult = 0;
            break;
        default:
            NSLog(@"erorr dates %@, %@", date1, date2);
            break;
    }
    return comparisonResult;
}

//处理时间格式，输入：yyyy-mm为参数；根据当前日期比较输出：10月，本月，或者2016年10月
-(NSString *)changeToMonthType{
    NSString * dateStr = @"";
    NSString * currentTime = [NSString currentName];
    NSString * currentYear = [currentTime stringByReplacingCharactersInRange:NSMakeRange(4, currentTime.length-4) withString:@""];
    NSString * currentYearMonth = [NSString stringWithFormat:@"%@-%@",[currentTime substringWithRange:NSMakeRange(0, 4)],[currentTime substringWithRange:NSMakeRange(4, 2)]];
    
    int yearIsEaqualresult = [NSString compareDate:[self substringWithRange:NSMakeRange(0, 4)] withDate:currentYear];
    int monthIsEaqualresult = [NSString compareDate:self withDate:currentYearMonth];
    NSLog(@"%d",[NSString compareDate:self withDate:currentTime]);
    
    if (yearIsEaqualresult == 0) {
        dateStr = [self substringWithRange:NSMakeRange(5, 2)];
        if (![dateStr isEqualToString:@"10"]) {
            dateStr = [dateStr stringByReplacingOccurrencesOfString:@"0" withString:@""];
            dateStr = [NSString stringWithFormat:@"%@月",dateStr];
        }else{
            dateStr = @"10月";
        }
        if(monthIsEaqualresult == 0){
            dateStr = @"本月";
        }
        return dateStr;
    }else {
        NSString * year = [self substringWithRange:NSMakeRange(0, 4)];
        NSString * month = [self substringWithRange:NSMakeRange(4, 2)];
        return [NSString stringWithFormat:@"%@年%@月",year,month];
    }
}


- (NSString *)firstStringSeparatedByString:(NSString *)separeted
{
    NSArray *list = [self componentsSeparatedByString:separeted];
    return [list firstObject];
}


- (BOOL)ET:(NSString *)string{
    return [self isEqualToString:string];
}



+(NSString *) timeChange:(NSString *)timeString
{
    //    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    //    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    //    [inputFormatter setDateFormat:@"yyyy-MM-ddTHH:mm:sszzz"];
    //    NSDate *inputDate = [inputFormatter dateFromString:timeString];
    //    NSLog(@"date = %@", timeString);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
    NSDate *currentDate = [dateFormatter dateFromString:timeString];
    
    //
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeChanged = [outputFormatter stringFromDate:currentDate];
//    NSLog(@"datestr = %@", timeChanged);
    
    
    return timeChanged;
}

-(NSString *) changeTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *currentDate = [dateFormatter dateFromString:self];
    
    //
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *timeChanged = [outputFormatter stringFromDate:currentDate];
    //    NSLog(@"datestr = %@", timeChanged);
    
    
    return timeChanged;
}

+(NSString *) timeChange:(NSString *)timeString format:(NSString *)formatString
{
    //    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    //    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    //    [inputFormatter setDateFormat:@"yyyy-MM-ddTHH:mm:sszzz"];
    //    NSDate *inputDate = [inputFormatter dateFromString:timeString];
    //    NSLog(@"date = %@", timeString);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
    NSDate *currentDate = [dateFormatter dateFromString:timeString];
    
    //
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc]init];
    [outputFormatter setDateFormat:formatString];
    NSString *timeChanged = [outputFormatter stringFromDate:currentDate];
    //    NSLog(@"datestr = %@", timeChanged);
    
    
    return timeChanged;
}

//有可能会少算一天
+ (NSInteger)getDifferenceByBeginDate:(NSString *)begindate endDate:(NSString *)endDate withFormat:(NSString *)format{
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式
    [dateFormatter setDateFormat:format];
    NSDate * begin =[dateFormatter dateFromString:begindate];
    NSDate * end = [dateFormatter dateFromString:endDate];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    unsigned int unitFlags1 = NSCalendarUnitHour;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:begin toDate:end options:0];
    NSDateComponents *comps1 = [gregorian components:unitFlags1 fromDate:begin toDate:end options:0];
    if ([comps1 hour]>[comps day]*24) {
        return [comps day]+1;
    }else{
        return [comps day];
    }
}

//这个不用了
//+ (BOOL)isMobileNumber:(NSString *)mobileNum
//{
//    if (mobileNum.length != 11)
//    {
//        return NO;
//    }
//    NSString *MOBILE = @"^((1[0-9][0-9]))\\d{8}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    return [regextestmobile evaluateWithObject:mobileNum];
//}

+(BOOL)isValidCertId:(NSString *)string{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!string) {
        return NO;
    }else {
        length = (int)string.length;
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [string substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    if (!areaFlag) {
        return false;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year =0;
    switch (length) {
        case 15:
            year = [string substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:string
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, string.length)];
            
            //            [regularExpression release];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [string substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:string
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, string.length)];
            
            //[regularExpression release];
            
            if(numberofMatch >0) {
                int S = ([string substringWithRange:NSMakeRange(0,1)].intValue + [string substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([string substringWithRange:NSMakeRange(1,1)].intValue + [string substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([string substringWithRange:NSMakeRange(2,1)].intValue + [string substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([string substringWithRange:NSMakeRange(3,1)].intValue + [string substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([string substringWithRange:NSMakeRange(4,1)].intValue + [string substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([string substringWithRange:NSMakeRange(5,1)].intValue + [string substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([string substringWithRange:NSMakeRange(6,1)].intValue + [string substringWithRange:NSMakeRange(16,1)].intValue) *2 + [string substringWithRange:NSMakeRange(7,1)].intValue *1 + [string substringWithRange:NSMakeRange(8,1)].intValue *6 + [string substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[string substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}


//判断是否银行卡
+ (BOOL) IsBankCard:(NSString *)cardNumber
{
    if(cardNumber.length==0 || cardNumber.length != 19)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

-(float)roundFloat{
    NSDecimalNumber *numResult = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                       scale:2
                                       raiseOnExactness:NO
                                       raiseOnOverflow:NO
                                       raiseOnUnderflow:NO
                                       raiseOnDivideByZero:YES];
    return [[numResult decimalNumberByRoundingAccordingToBehavior:roundUp] floatValue];
}

-(BOOL)judgePhoneNumber{
    NSString * regex = @"^((1[0-9][0-9]))\\d{8}$";
    NSPredicate *teldicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    if ([teldicate evaluateWithObject:self]) {
        return YES;
    }else{
        return NO;
    }
}

//(是否为空格)
- (BOOL)judgeIsBlank
{
    NSString *passWordRegex = @"^[^ ]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }else{
        return NO;
    }
}

//判断字母数字符号(无空格)
- (BOOL)judgePassWord
{
    NSString *passWordRegex = @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }else{
        return NO;
    }
}


-(NSString *)trimLeadingAndTraingBlank{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (int)daysIntervalBetweenDateString:(NSString *)beginDate toDateString:(NSString *)endDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate * begin = [dateFormatter dateFromString:beginDate];
    NSDate * end = [dateFormatter dateFromString:endDate];
    
    NSTimeInterval time = [end timeIntervalSinceDate:begin];
    
    int days = ((int)time)/(3600*24);
    
    //    int hours = ((int)time)%(3600*24)/3600;
    //
    //    int minutes = ((int)time)%(3600*24)%3600/60;
    //
    //    int seconds = ((int)time)%(3600*24)%3600%60;
    
    return days;
}

- (NSMutableAttributedString *)changeDigitNumberToRed{
    
    //下面是要变色的字符串  需要NSMutableAttributedString字体
    
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:self];
    
    //下面是要变色的字符串
    
    NSString * nsstring = [NSString stringWithFormat:@"%@",AttributedStr];
    
    // 取出字符串长度做循环
    
    for(int i =0; i < [nsstring length]; ++i) {
        
        // 取出第几位
        
        int a = [nsstring characterAtIndex:i];
        
        //判断是否为数字
        
        if(isdigit(a)){
            
            [AttributedStr addAttribute:NSForegroundColorAttributeName
             
                                  value:[UIColor redColor]
             
                                  range:NSMakeRange(i,1)];
            
        }else{
            NSLog(@"%d",i);
        }
        
    }
    return AttributedStr;
}


-(NSMutableAttributedString *)changeSubStr:(NSString *)subStr WithColor:(UIColor *)color{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self];
    NSRange range = [self rangeOfString:subStr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attributedString;
}



- (NSString *)changeTimeModeWithType:(NSInteger)type{
    NSTimeInterval  timeSta = [self doubleValue];
    NSDateFormatter * dfmatter = [NSDateFormatter new];
    
    if (type == 0) {
        dfmatter.dateFormat = @"HH:mm:ss";
    }else if (type == 1) {
        dfmatter.dateFormat = @"YYYY-MM-dd";
    }else if (type == 2) {
        dfmatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    }else if (type == 3) {
        dfmatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        NSDate * date = [[NSDate alloc]initWithTimeIntervalSince1970:timeSta];
        NSTimeInterval timeInterval = [date timeIntervalSinceNow];
        timeInterval = -timeInterval;
        NSString * timeString = [NSString new];
        if (timeInterval < 60) {
            timeString = @"刚刚";
        }else if ((timeInterval / 60) < 60){
            timeString = @"\(NSInteger(timeInterval / 60)) 分钟前";
        } else if((timeInterval/60/60) < 24){
            timeString = @"\(NSInteger(timeInterval/60/60)) 小时前";
        } else {
            if ((timeInterval/60/60/24 > 1) && (timeInterval/60/60/24 < 2)) {
                timeString = @"昨天";
            } else {
                dfmatter.dateFormat = @"YYYY-MM-dd";
                timeString = [dfmatter stringFromDate:date];
            }
        }
        return timeString;
    }
    NSDate * date = [[NSDate alloc]initWithTimeIntervalSince1970:timeSta];
    return [dfmatter stringFromDate:date];
    
}


-(NSString *) aes256_encrypt:(NSString *)key
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    //对数据进行加密
    NSData *result = [data aes256_encrypt:key];
    
    //转换为2进制字符串
    if (result && result.length > 0) {
        
        Byte *datas = (Byte*)[result bytes];
        NSMutableString *output = [NSMutableString stringWithCapacity:result.length * 2];
        for(int i = 0; i < result.length; i++){
            [output appendFormat:@"%02x", datas[i]];
        }
        return output;
    }
    return nil;
}

-(NSString *) aes256_decrypt:(NSString *)key
{
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++) {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    
    //对数据进行解密
    NSData* result = [data aes256_decrypt:key];
    if (result && result.length > 0) {
        return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString*) EncodeText:(NSString*)plainText enc:(CCOperation)encryptOrDecrypt{
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSString *base64EncodedString = [[plainText dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0];
        NSData *encryptData = [[NSData alloc]initWithBase64EncodedString:base64EncodedString options:0];
        plainTextBufferSize = [encryptData length];
        vplainText = [encryptData bytes];
    }
    else
    {
        plainTextBufferSize = [plainText length];
        vplainText = (const void *) [plainText UTF8String];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    // 设置你的AES key
    const unsigned char *keyString = (const unsigned char *)[@"ASAF#Key$M0BiLE!WS@DG_1@"  cStringUsingEncoding: NSUTF8StringEncoding];
    // 这里你的AES IV
    const unsigned char *initializeVactorString = (const unsigned char *)[@"ASAF@DG#" cStringUsingEncoding: NSUTF8StringEncoding];
    
    uint8_t iv[kCCBlockSize3DES];
    memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       keyString,
                       kCCKeySize3DES,
                       initializeVactorString,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    if (ccStatus == kCCSuccess){ NSLog(@"SUCCESS");}else{
        if (ccStatus == kCCParamError) return @"PARAM ERROR";
        else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
        else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
        else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
        else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
        else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED";
    }
    
    NSString *result;
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [ [NSString alloc] initWithData: [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes] encoding:NSASCIIStringEncoding];
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [myData base64EncodedStringWithOptions:0];
    }
    NSLog(@"%@",result);
    
    return result;
}


-(NSString *)utf8ToUnicode:(NSString *)string{
    NSUInteger length = [string length];
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++){
        NSMutableString *s = [NSMutableString stringWithCapacity:0];
//        unichar _char = [string characterAtIndex:i];
        // 判断是否为英文和数字
//        if (_char <= '9' && _char >='0'){
//            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
//        }else if(_char >='a' && _char <= 'z'){
//            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
//        }else if(_char >='A' && _char <= 'Z')
//        {
//            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
//        }else{
            // 中文和字符
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
            // 不足位数补0 否则解码不成功
            if(s.length == 4) {
                [s insertString:@"00" atIndex:2];
            } else if (s.length == 5) {
                [s insertString:@"0" atIndex:2];
            }
//        }
        [str appendFormat:@"%@", s];
    }
    return str;
}

-(NSString *)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString: @"\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\r\n"withString:@"\n"];
}


@end
