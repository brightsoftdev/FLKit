//
//  NSDate+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

/** Special thanks to Eric Sadun for her Date utilies used here with some ARCification **/

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

struct DateInformation {
	int day;
	int month;
	int year;
	
	int weekday;
	
	int minute;
	int hour;
	int second;
	
};
typedef struct DateInformation DateInformation;

typedef enum {
    
    NSDateSecondsType = 0,
    NSDateMinutesType = 1,
    NSDateHoursType   = 2,
    NSDateDaysType    = 3,
    NSDateWeekType    = 4,
    NSDateMonthsType  = 5,
    NSDateYearType    = 6
    
} NSDateTimeType;


@interface NSDate (FLKit)

// Relative dates from the current date
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSUInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSUInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSUInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSUInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSUInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSUInteger) dMinutes;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

// Adjusting dates
- (NSDate *) dateByAddingDays: (NSUInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSUInteger) dDays;
- (NSDate *) dateByAddingHours: (NSUInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSUInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSUInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSUInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

// Additions Made By Wess
@property (readonly) NSString *monthStringAbbreviated;

+ (int)unixTimestampFromDate:(NSDate *)aDate;
+ (int)unixTimestampNow;
+ (NSDate *)date:(NSDate *)aDate add:(NSUInteger)increment of:(NSDateTimeType)type;
- (NSDate*) timelessDate;
- (NSDate*) monthlessDate;
- (BOOL) isSameDay:(NSDate*)anotherDate;
- (int) monthsBetweenDate:(NSDate *)toDate;
- (NSInteger) daysBetweenDate:(NSDate*)d;
- (DateInformation) dateInformation;
- (DateInformation) dateInformationWithTimeZone:(NSTimeZone*)tz;
+ (NSDate*) dateFromDateInformation:(DateInformation)info;
+ (NSDate*) dateFromDateInformation:(DateInformation)info timeZone:(NSTimeZone*)tz;
+ (NSString*) dateInformationDescriptionWithInformation:(DateInformation)info;

@end
