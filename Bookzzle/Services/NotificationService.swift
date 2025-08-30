//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

@Observable
final class NotificationService {
    
    // MARK: - PROPERTIES
    var currentNotification: NotificationMessage?
    var showNotification: Bool = false
    
    // MARK: - METHODS
    func show(message: NotificationMessage) {
        let notification = NotificationMessage(type: message.type, title: message.title, message: message.message, duration: message.duration)
        withAnimation(.spring()) {
            currentNotification = notification
            showNotification = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + message.duration) {
            self.hide()
        }
    }
    
    func show(type: NotificationType, title: String, message: String, duration: Double = 3.0) {
        let notification = NotificationMessage(type: type, title: title, message: message, duration: duration)
        withAnimation(.spring()) {
            currentNotification = notification
            showNotification = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.hide()
        }
    }
    
    func hide() {
        withAnimation(.easeOut(duration: 0.3)) {
            currentNotification = nil
            self.showNotification = false
        }
    }
    
}
