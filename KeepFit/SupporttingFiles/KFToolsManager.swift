//
//  KFToolsManager.swift
//  KeepFit
//
//  Created by 龚梦洋 on 2023/7/25.
//

import Foundation
import UIKit

class KFToolsManager: NSObject {
    
    static func getWindows() -> [UIWindow] {
        var windows: [UIWindow] = []
        if #available(iOS 15.0, *) {
            windows = UIApplication.shared.connectedScenes.flatMap({
                ($0 as? UIWindowScene)?.windows ?? []
            })
        } else {
            windows = UIApplication.shared.windows
        }
        return windows
    }
    
    static func getKeyWindow() -> UIWindow? {
        return KFToolsManager.getWindows().filter { window in
            return window.isKeyWindow
        }.first
    }
    
    static func weekday(day: String) -> String {
        switch day {
        case "SUN":
            return "星期日"
        case "MON":
            return "星期一"
        case "TUE":
            return "星期二"
        case "WED":
            return "星期三"
        case "THU":
            return "星期四"
        case "FRI":
            return "星期五"
        case "SAT":
            return "星期六"
        default:
            return ""
        }
    }
}
