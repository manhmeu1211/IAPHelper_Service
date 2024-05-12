//
//  String+Ext.swift
//
//  Created by Luong Manh on 4/5/20.
//  Copyright © 2022 Luong Manh. All rights reserved.
//

import Foundation

extension String {
    public func toBool() -> Bool {
        switch self.lowercased() {
        case "true", "yes", "1":
            return true
        default:
            return false
        }
    }
}
