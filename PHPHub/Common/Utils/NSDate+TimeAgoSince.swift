//
//  NSDate+TimeAgoSince.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/10.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import Foundation

extension NSDate {
    func timeAgoSinceNow() -> String {
        return ""
    }
    
    func timeAgoSinceDate(date: NSDate, numericDates: Bool) -> String {
        
        let calendar = NSCalendar.currentCalendar()
        let unitFlags: NSCalendarUnit = [ .Year, .Month, .WeekOfYear, .Day, .Hour, .Minute, .Second ]
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = earliest == now ? date : now
        let components = calendar.components(unitFlags, fromDate: earliest, toDate: latest, options: [])
        
        switch components {
        case components.year >= 2:
            return "\(components.year)年前"
        case components.year >= 1:
            return numericDates ? "1年前" : "去年"
        case components.month >= 2:
            return "\(components.day)月前"
        case components.month >= 1:
            return numericDates ? "1月前" : "上个月"
        case components.weekOfYear >= 2:
            return "\(components.weekOfYear)周前"
        case components.weekOfYear >= 1:
            return numericDates ? "1周前" : "上周"
        case components.day >= 2:
            return "\(components.day)天前"
        case components.day >= 1:
            return numericDates ? "1天前" : "昨天"
        case components.hour >= 2:
            return "\(components.hour)小时前"
        case components.hour >= 1:
            return numericDates ? "1小时前" : "一小时前"
        case components.minute >= 2:
            return "\(components.minute)分钟前"
        case components.minute >= 1:
            return numericDates ? "1分钟前" : "一分钟前"
        case components.second >= 3:
            return "\(components.second)秒前"
        default:
            return "刚刚"
        }
    }
}
