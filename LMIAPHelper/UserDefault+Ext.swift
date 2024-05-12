//
//  UserDefault+Ext.swift
//
//  Created by Luong Manh on 4/5/20.
//  Copyright © 2022 Luong Manh. All rights reserved.
//

import Foundation

extension UserDefaults {
    public func rateValue(for key: String) -> Int {
        return integer(forKey: key)
    }
    
    public func setRateValue(_ value: Int, forKey: String) {
        setValue(value, forKey: forKey)
    }
}
