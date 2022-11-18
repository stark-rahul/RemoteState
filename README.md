# AnywhereUtilityKit

![Datekit](https://vishwaiosdev.github.io/images-repo/Banner_DateKit.png)

<p align="center"><strong>Toolkit to Format Date/Time and display Relativetime & timezones in Swift.</strong></p>

A brief description of what this project does and who it's for

## What's This?

AnywhereUtils is the **definitive toolchain for method to convert epoch time in time format, date format & definite TimeZones** on all Apple platform like MacOS or IPadOS.

From simple date/time format to complex business logic Anywhere-Utiles maybe the right choice for your next project.

### Explore DateKit
Let me show to you the main features of the library:

- [Setup method](#1)
- [Formatted date](#2)
- [Date range formatting](#3)
- [Relative time](#4)

<a name="1"/>

### 1. Setup method

To use this DateFormatter you should have to depoly the setup region (`Datekit.shared.setUp(Region:_)`) to make sure the singlton design pattern has to be constructed and parse the specific zone your intended to be to get the whole timezone related string format.

```swift
// SetUp 
let region: String = "Asia/Kolkata"
DateKit.shared.setUp(region: Region(zone: TimeZone(identifier: region)
```

<a name="2"/>

### 2. Formatted date

- [x] **Easy Date Parsing** (Custom formats, Epochtime to String)
- [x] **We use the 12-hour clock**
- [x] **We use leading 0 on hours while using AM or PM**
- [x] **We use Time of day should be in AM or PM**
- [x] **We use Time zone with respect to setUp-Regions** (`(PST) - LosAngels, (IST) - kolkata` etc.)
- [x] **We use the 12-hour clock as follows with timezones** (`10:00 PM (PST), 6:01 PM (IST)` etc.)

DateKit can recognize epoch-datetime formats automatically, and you can also provide your own formats. Creating a new TimeFormat has never been so easy! However not anymore!

- [x] → **formattedDate Methods**
- `.day_Date_Month`
- `.day_Date_Month_Year`
- `.date_Month_Year`
- `.timeAM_PM`
- `.time_TimeZone`
- `.time_Offset`
- `.date_Time`
- `.date_Month`
- `.day_Date`
- `.custom`


```swift
// formattedDate follows 
let time: Double = 1665731291

dateKit.formattedDate(time: time, .timeAM_PM)                        // "12:38 PM"
dateKit.formattedDate(time: time, .time_TimeZone)                    // "12:38 PM (IST)"
dateKit.formattedDate(time: time, .time_Offset)                      // "12:38 PM (GMT+05:30)"
dateKit.formattedDate(time: time, .date_Month)                       // "14 Oct"
dateKit.formattedDate(time: time, .date_Month_Year)                  // "14 Oct 2022"
dateKit.formattedDate(time: time, .day_Date)                         // "Fri 14"
dateKit.formattedDate(time: time, .day_Date_Month)                   // "Fri 14 Oct"
dateKit.formattedDate(time: time, .day_Date_Month_Year)              // "Fri 14 Oct"
dateKit.formattedDate(time: time, .date_Time)                        // "Fri 14 Oct 2022 • 12:38 PM (IST)"

//To get custom desired format. You go ahead with this.
dateKit.formattedDate(time: time, .custom("EEEE, MMM d, yyyy"))      // "Friday, Oct 14, 2022"

```

<a name="3"/>

### 3. Date range formatting.

- [x] **Easy Date Parsing for crossing days** (Epochtime to String with crossing days)
- [x] **We use the 12-hour clock**
- [x] **We use leading 0 on hours while using AM or PM**
- [x] **We use Time of day should be in AM or PM**
- [x] **We use Time zone with respect to setUp-Regions** (`(PST) - LosAngels, (IST) - kolkata` etc.)
- [x] **We use the 12-hour clock as follows with timezones** (`10:00 PM (PST), 6:01 PM (IST)` etc.)

DateKit we can manage by using crossing AM/PM and Days & Not crossing AM/PM and Days to match up with this methods allows extra params like (`.fromTime`) & (`.toTime`). 
- [x] → **formattedDate-Range Methods**
- `.date_Time_Not_Crossing_AMPM`
- `.date_Time_Crossing_AMPM`
- `.date_Time_Crossing_days`
- `.date_Time_Crossing_AMPM_And_days`

```swift
// formattedDate follows  
let fromTime: Double = 1665731291
let toTime : Double = 1665728955

dateKit.formattedCrossingDate(fromTime: fromTime, toTime: toTime, .date_Time_Not_Crossing_AMPM)       // "Fri 14 Oct 2022 • 7:16 AM – 11:59 AM"
dateKit.formattedCrossingDate(fromTime: fromTime, toTime: toTime, .date_Time_Crossing_AMPM)           // "Fri 14 Oct 2022 • 7:16 AM – 10:40 PM"
dateKit.formattedCrossingDate(fromTime: fromTime, toTime: toTime, .date_Time_Crossing_days)           // "Fri 14 Oct 2022 • 4:00 PM – Sat 15 Oct 2022 • 4:00 PM"
dateKit.formattedCrossingDate(fromTime: fromTime, toTime: toTime, .date_Time_Crossing_AMPM_And_days)  // "Fri 14 Oct 2022 • 7:16 AM – Sat 15 Oct 2022 • 8:30 PM"

```
<a name="4"/>

### 4. Relative time.
DateKit automatically recognise and manage by relative time with Default `NSDate()` region timezone. And the method `dateKit.relativeTimeWithDefaultFormat(of: _time)` will take care of the rest as follows the below format.
- [x] → **Relative time methods** 

| Time/date range | Previous | Upcoming |
| ------------- | ------------- | ------------- |
| If diff B/W 59 seconds | Just now | Just now |
| If diff B/W Last minute | A minute ago | In 1 minute |
| If diff B/W Last 59 minutes | [Number] minutes ago | In [Number] minutes |
| If diff B/W 60 minutes | 1 hour ago | In 1 hour |
| If diff B/W [Number] hours | [Number] hours ago | In [Number] hours |
| If diff B/W 1 day ago | Yesterday · 10:37 AM | Tomorrow · 10:37 AM |
| If diff B/W 2 to 6 days | [Number] days ago · 10:37 AM |  In [Number] days · 10:37 AM |
| If diff B/W 7 or more days | Mon 23 May 2022 · 10:37 AM |  Mon 23 May 2022 · 10:37 AM  |

```swift
// Relative Date/Time follows 

let createdTime: Double = 1666739160 
dateKit.relativeTimeWithDefaultFormat(of: createdTime)
```
