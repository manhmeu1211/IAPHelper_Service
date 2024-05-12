//
//  ASPendingRenewal.swift
//
//  Created by Luong Manh on 4/5/20.
//  Copyright © 2022 Luong Manh. All rights reserved.
//

import Foundation

/// In the JSON file, pending_renewal_info is an array in which each element contains the pending renewal information for each auto-renewable subscription identified by the product_id. A pending renewal may refer to a renewal that the system scheduled in the future or a renewal that failed in the past for some reason.
/// Use this value to get critical information about any pending renewal transactions for an auto-renewable subscription.
/// The pending_renewal_info array is returned only for app receipts that contain auto-renewable subscriptions. If customers voluntarily cancel a subscription renewal while in the grace period, the App Store pauses billing retry, and removes the transaction from pending_renewal_info. The subscription is in the grace period if the key grace_period_expires_date_ms is present and the expiration date hasn't passed.
public struct ASPendingRenewal: Decodable {
    ///The value for this key corresponds to the productIdentifier property of the product that the customer’s subscription renews.
    public var auto_renew_product_id: String?
    
    /// The current renewal status for the auto-renewable subscription. See auto_renew_status for more information.
    public var auto_renew_status: AutoRenewStatus?

    /// The reason a subscription expired. This field is present only for a receipt that contains an expired auto-renewable subscription.
    public var expiration_intent: ASExpirationIntent?
    
    /// The time at which the grace period for subscription renewals expires, in a date-time format similar to the ISO 8601.
    public var grace_period_expires_date: Date?
    
    /// The time at which the grace period for subscription renewals expires, in UNIX epoch time format, in milliseconds. This key is present only for apps that have Billing Grace Period enabled and when the user experiences a billing error at the time of renewal. Use this time format for processing dates.
    public var grace_period_expires_date_ms: String?

    // The time at which the grace period for subscription renewals expires, in the Pacific Time zone.
    public var grace_period_expires_date_pst: String?
    
    /// A flag that indicates Apple is attempting to renew an expired subscription automatically. This field is present only if an auto-renewable subscription is in the billing retry state. See is_in_billing_retry_period for more information.
    public var is_in_billing_retry_period: String?
    
    /// The reference name of a subscription offer that you configured in App Store Connect. This field is present when a customer redeemed a subscription offer code. For more information, see [offer_code_ref_name](https://developer.apple.com/documentation/appstorereceipts/offer_code_ref_name).
    public var offer_code_ref_name: String?
    
    /// The transaction identifier of the original purchase.
    public var original_transaction_id: String?
    
    /// The price consent status for an auto-renewable subscription price increase that requires customer consent. This field is present only if the App Store requested customer consent for a price increase that requires customer consent. The default value is "0" and changes to "1" if the customer consents.
    /// Possible values: 1, 0
    public var price_consent_status: String?
    
    /// The unique identifier of the product purchased. You provide this value when creating the product in App Store Connect, and it corresponds to the productIdentifier property of the SKPayment object stored in the transaction's payment property.
    public var product_id: String?

    /// The identifier of the promotional offer for an auto-renewable subscription that the user redeemed. You provide this value in the Promotional Offer Identifier field when you create the promotional offer in App Store Connect.
    public var promotional_offer_id: String?
    
    /// The status that indicates if an auto-renewable subscription is subject to a price increase.
    /// The price increase status is "0" when the App Store has requested consent for an auto-renewable subscription price increase that requires customer consent, and the customer hasn't yet consented.
    /// The price increase status is "1" if the customer has consented to a price increase that requires customer consent.
    /// The price increase status is also "1" if the App Store has notified the customer of the auto-renewable subscription price increase that doesn't require customer consent.
    /// Possible values: 1, 0
    public var price_increase_status: String?
}
