//
//  Message.swift
//  FireChat
//
//  Created by Tomer Buzaglo on 04/09/2017.
//  Copyright © 2017 iTomerBu. All rights reserved.
//

import Foundation
import MessageKit

struct Message: MessageType {
    
    var messageId: String
    var sender: Sender
    var sentDate: Date
    var data: MessageData
    
    private init(data: MessageData, sender: Sender, messageId: String) {
        self.data = data
        self.sender = sender
        self.messageId = messageId
        self.sentDate = Date()
    }
    
    init(text: String, sender: Sender, messageId: String) {
        self.init(data: .text(text), sender: sender, messageId: messageId)
    }
    
    init(attributedText: NSAttributedString, sender: Sender, messageId: String) {
        self.init(data: .attributedText(attributedText), sender: sender, messageId: messageId)
    }
    
}
