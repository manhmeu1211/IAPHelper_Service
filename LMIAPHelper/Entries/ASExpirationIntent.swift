//
//  ASExpirationIntent.swift
//
//  Created by Luong Manh on 4/5/20.
//  Copyright © 2022 Luong Manh. All rights reserved.
//

import Foundation

public enum ASExpirationIntent: String, Decodable {
    /// The customer canceled their subscription.
    case cancel = "1"
    
    /// Billing error; for example, the customer’s payment information is no longer valid.
    case billingError = "2"
    
    /// The customer didn’t consent to an auto-renewable subscription price increase that requires customer consent, allowing the subscription to expire.
    case requiresCustomerConsent = "3"
    
    /// The product wasn’t available for purchase at the time of renewal.
    case productNotAvailable = "4"
    
    /// Unknown error.
    case error = "5"
}
