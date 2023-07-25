//
//  KFRecordModel.swift
//  KeepFit
//
//  Created by 龚梦洋 on 2023/7/26.
//

import Foundation
import ObjectMapper

class KFRecordModel: KFBaseModel {
    
    var date: String?
    var record: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        date    <- map["date"]
        record  <- map["record"]
    }
}
