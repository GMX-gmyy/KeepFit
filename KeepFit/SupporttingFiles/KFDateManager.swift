//
//  DateManage.swift
//  KeepFit
//
//  Created by 龚梦洋 on 2023/7/25.
//

import Foundation

class KFDateManager {
    
    public static func getCurrentTime(timeFormat:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormat
        let timezone = TimeZone(identifier: "Asia/Beijing")
        formatter.timeZone = timezone
        let dateTime = formatter.string(from: Date())
        return dateTime
    }
}
