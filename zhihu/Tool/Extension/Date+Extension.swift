//
//  Date+Extension.swift
//  
//
//  Created by 陈淑洋 on 2018/11/22.
//

import Foundation


extension Date {
    
    ///将时间显示为（几分钟前，几小时前，几天前）
    
    static func getCreatedDate(str:Double) -> String {
        
        //将时间戳转换为日期
        let time:TimeInterval = TimeInterval(str)
        let timeDate = Date(timeIntervalSince1970: time)
        let currentDate = NSDate()
        let timeInterval = currentDate.timeIntervalSince(timeDate)
        var temp:Double = 0
        var result:String = ""
        if timeInterval/60 < 1 {
            result = "刚刚"
        }else if (timeInterval/60) < 60{
            temp = timeInterval/60
            result = "\(Int(temp)) 分钟前"
        }else if timeInterval / 60 < 24 * 60 {
            temp = timeInterval/(60 * 60)
            result = "\(Int(temp)) 小时前"
        }else if timeInterval/(24 * 60 * 60) < 30 * 24 * 60 {
            temp = timeInterval / (24 * 60 * 60)
            result = "\(Int(temp)) 天前"
        }else if timeInterval/(30 * 24 * 60 * 60)  < 12 * 30 * 24 * 60{
            temp = timeInterval/(30 * 24 * 60 * 60)
            result = "\(Int(temp)) 个月前"
        }else{
            temp = timeInterval/(12 * 30 * 24 * 60 * 60)
            result = "\(Int(temp)) 年前"
        }
        return result
    }
    
    
    
    static func getCreatedDate(created:String) -> String {
        let form = DateFormatter()
//        form.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy"
        let timeInterval:TimeInterval = TimeInterval(created)!
//        form.locale = Locale(identifier: "en_US")
//        let createdDate = form.date(from: created)!
        let createdDate = Date(timeIntervalSince1970: timeInterval)
        if createdDate.isThisYear(){
            if createdDate.isToday() { //今天
                let cmps = Date().deltaFrom(date: createdDate)
                if (cmps.hour! >= 1) {
                    return "\(cmps.hour!) 小时前"
                }else if (cmps.minute! >= 1){
                    return  "\(cmps.minute!) 分钟前"
                }else{
                    return "刚刚"
                }
            }else if createdDate.isYesterday() { //昨天
                form.dateFormat = "昨天 HH:mm";
                return form.string(from: createdDate)
            }else{
                form.dateFormat = "MM-dd HH:mm"
                return form.string(from: createdDate)
            }
        }else{ //非今年
            form.dateFormat = "yyyy-MM-dd HH:mm"
            return form.string(from: createdDate)
        }
    }
    
    func isThisYear() -> Bool {
        let calendar = Calendar.current
        let nowYear = calendar.component(Calendar.Component.year, from: Date())
        let selfYear = calendar.component(Calendar.Component.year, from: self)
        return nowYear == selfYear
    }
    
    func isToday() -> Bool {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let nowString = fmt.string(from:Date())
        let selfString = fmt.string(from:self)
        return nowString == selfString
    }
    
    func isYesterday() -> Bool {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let cmps = Calendar.current.dateComponents([.day,.month,.year], from: self, to: Date())
        return cmps.year == 0
            && cmps.month == 0
            && cmps.day == 1
    }
    
    func deltaFrom(date:Date) -> DateComponents {
        return Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date, to: Date())
    }
    
    
}
