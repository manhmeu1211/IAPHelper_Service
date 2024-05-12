//
//  ASReceiptType.swift
//
//  Created by Luong Manh on 4/5/20.
//  Copyright © 2022 Luong Manh. All rights reserved.
//

import Foundation

extension ASReceipt {
    public enum ReceiptType: String, Decodable {
        case Production, ProductionVPP, ProductionSandbox, ProductionVPPSandbox
    }
}
