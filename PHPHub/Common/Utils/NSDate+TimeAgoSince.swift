//
//  NSDate+TimeAgoSince.swift
//  PHPHub
//
//  Created by 2014-104 on 15/12/10.
//  Copyright © 2015年 ninerec. All rights reserved.
//

import Foundation

extension Date {
    func timeAgoSinceNow() -> String {
        return timeAgoSinceDate(self, numericDates: true)
    }
    
    func timeAgoSinceDate(_ date: Date, numericDates: Bool) -> String {
        
        let calendar = Calendar.current
        let unitFlags: NSCalendar.Unit = [ .year, .month, .weekOfYear, .day, .hour, .minute, .second ]
        let now = Date()
        let earliest = (now as NSDate).earlierDate(date)
        let latest = earliest == now ? date : now
        let components = (calendar as NSCalendar).components(unitFlags, from: earliest, to: latest, options: [])
        
        if components.year! >= 2{
            return "\(components.year)年前"
        } else if components.year! >= 1 {
            return numericDates ? "1年前" : "去年"
        } else if components.month! >= 2{
            return "\(components.month)月前"
        } else if components.month! >= 1 {
            return numericDates ? "1月前" : "上个月"
        } else if components.weekOfYear! >= 2 {
            return "\(components.weekOfYear)周前"
        } else if components.weekOfYear! >= 1 {
            return numericDates ? "1周前" : "上周"
        } else if components.day! >= 2 {
            return "\(components.day)天前"
        } else if components.day! >= 1 {
            return numericDates ? "1天前" : "昨天"
        } else if components.hour! >= 2 {
            return "\(components.hour)小时前"
        } else if components.hour! >= 1 {
            return numericDates ? "1小时前" : "一小时前"
        } else if components.minute! >= 2 {
            return "\(components.minute)分钟前"
        } else if components.minute! >= 1 {
            return numericDates ? "1分钟前" : "一分钟前"
        } else if components.second! >= 3 {
            return "\(components.second)秒前"
        }
        
        return "刚刚"
    }
    
    static func convertFromString(_ stringData: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        
        let date = dateFormatter.date(from: stringData)
        return date
    }
    
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
