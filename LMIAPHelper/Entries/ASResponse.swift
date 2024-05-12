//
//  ASResponse.swift
//
//  Created by Luong Manh on 4/5/20.
//  Copyright © 2022 Luong Manh. All rights reserved.
//

import Foundation

public struct ASResponse: Decodable {
    /// The environment for which the receipt was generated.
    /// Possible values: Sandbox, Production
    public var environment: Enviroment?
    
    /// An indicator that an error occurred during the request.
    /// A value of 1 indicates a temporary issue; retry validation for this receipt at a later time.
    /// A value of 0 indicates an unresolvable issue; do not retry validation for this receipt. Only applicable to status codes 21100-21199.
    public var is_retryable: Bool?
    
    /// The latest Base64 encoded app receipt.
    /// Only returned for receipts that contain auto-renewable subscriptions.
    public var latest_receipt: Data?
    
    /// An array that contains all in-app purchase transactions.
    /// This excludes transactions for consumable products that have been marked as finished by your app.
    /// Only returned for receipts that contain auto-renewable subscriptions.
    public var latest_receipt_info: [ASLastestReceiptInfo]?
    
    /// In the JSON file, an array where each element contains the pending renewal information for each auto-renewable subscription identified by the product_id.
    /// Only returned for app receipts that contain auto-renewable subscriptions.
    public var pending_renewal_info: [ASPendingRenewal]?
    
    /// A JSON representation of the receipt that was sent for verification.
    public var receipt: ASReceipt?
    
    /// Either 0 if the receipt is valid, or a status code if there is an error.
    /// The status code reflects the status of the app receipt as a whole. See status for possible status codes and descriptions.
    public var status: Status?
}


public extension ASResponse {
    enum ResponseError: Error {
        case wrongEnviroment
        case unknown(reason: Any)
    }
}

public extension ASResponse {
    enum Enviroment: String, Decodable {
        case sandbox = "Sandbox"
        case production = "Production"
    }
}
