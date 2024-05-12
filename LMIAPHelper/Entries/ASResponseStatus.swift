//
//  ASResponseStatus.swift
//
//  Created by Luong Manh on 4/5/20.
//  Copyright © 2022 Luong Manh. All rights reserved.
//

import Foundation

extension ASResponse {
    /// This field is returned in the JSON response, responseBody.
    /// The value for status is 0 if the receipt is valid, or a status code if there is an error. The status code reflects the status of the app receipt as a whole. For example, if you send a valid app receipt that contains an expired subscription, the response is 0 because the receipt is valid.
    /// Status codes 21100-21199 are various internal data access errors.
    public enum Status: Int, Decodable {
        /// the receipt is valid
        case valid = 0
        /// The request to the App Store was not made using the HTTP POST request method.
        case wasNotPostMethod = 21000
        /// This status code is no longer sent by the App Store.
        case noLongerUsed = 21001
        /// The data in the receipt-data property was malformed or the service experienced a temporary issue. Try again.
        case invalidData = 21002
        /// The receipt could not be authenticated.
        case notAuthenticated = 21003
        /// The shared secret you provided does not match the shared secret on file for your account.
        case sharedSecretNotMatch = 21004
        ///The receipt server was temporarily unable to provide the receipt. Try again.
        case receiptTemporarilyUnavailable = 21005
        /// This receipt is valid but the subscription has expired. When this status code is returned to your server, the receipt data is also decoded and returned as part of the response. Only returned for iOS 6-style transaction receipts for auto-renewable subscriptions.
        case expired = 21006
        /// This receipt is from the test environment, but it was sent to the production environment for verification.
        case mustSendFromTestEnviroment = 21007
        /// This receipt is from the production environment, but it was sent to the test environment for verification.
        case mustSendFromProductionEnviroment = 21008
        /// Internal data access error. Try again later.
        case dataAccessError = 21009
        /// The user account cannot be found or has been deleted.
        case accountNotFound = 21010
    }
}
