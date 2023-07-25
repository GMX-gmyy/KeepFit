//
//  KFRecordManager.swift
//  KeepFit
//
//  Created by 龚梦洋 on 2023/7/26.
//

import Foundation

let kfRecord = "kfRecord"
class KFRecordManager: NSObject {
    static let share = KFRecordManager()
    
    func getRecordInfo() -> [KFRecordModel] {
        let string = (UserDefaults.standard.value(forKey: kfRecord) as? String) ?? ""
        if string.count == 0 {
            return []
        }
        let model = Array<KFRecordModel>(JSONString: string) ?? []
        return model
    }
    
    func saveRecordInfo(model: KFRecordModel) {
        var models = getRecordInfo()
        models.append(model)
        UserDefaults.standard.set(models.toJSONString(), forKey: kfRecord)
        UserDefaults.standard.synchronize()
    }
}
