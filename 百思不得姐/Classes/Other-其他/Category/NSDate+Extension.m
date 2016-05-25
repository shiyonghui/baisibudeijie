//
//  NSDate+Extension.m
//  百思不得姐
//
//  Created by 施永辉 on 16/4/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    //日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
    //比较时间
    NSCalendarUnit unit = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear |NSCalendarUnitHour|NSCalendarUnitMinute |NSCalendarUnitSecond;
    return [calendar components:unit fromDate:from toDate:self options:0];
}

- (BOOL)isThisYear
{
    
    //日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
   NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear == selfYear;
}
- (BOOL)isToday
{
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString * nowString =[fmt stringFromDate:[NSDate date]];
    NSString * selfString = [fmt stringFromDate:self];
    return [nowString isEqualToString:selfString];
}
- (BOOL)isYesterday
{
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate * nowDate =[fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate * selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * cmps = [calendar components:NSCalendarUnitDay |NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

@end
