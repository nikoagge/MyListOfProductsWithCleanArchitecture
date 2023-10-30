//
//  FeedbackInfoMessage.swift
//  Domain
//
//  Created by Nikos Aggelidis on 29/10/23.
//

import Foundation

public enum FeedbackInfoMessageType {
    case error
    case info
    case success
}

public struct FeedbackInfoMessage {
    public let message: String
    public let feedbackInfoMessageType: FeedbackInfoMessageType
    
    public init(
        message: String,
        feedbackInfoMessageType: FeedbackInfoMessageType) {
        self.message = message
        self.feedbackInfoMessageType = feedbackInfoMessageType
    }
}
