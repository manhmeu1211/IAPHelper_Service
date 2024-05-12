//
//  ASAutoRenewStatus.swift
//
//  Created by Luong Manh on 4/5/20.
//  Copyright © 2022 Luong Manh. All rights reserved.
//

import Foundation

extension ASPendingRenewal {
    public enum AutoRenewStatus: String, Decodable {
        case renewAutomatically = "1"
        case turnOffAutorenew = "0"
    }
}
