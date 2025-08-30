//
// Bookzzle
//
// Created by The Architect on 8/30/25
// Copyright (c) 2025 The Architect Labs. All Rights Reserved.
//

import SwiftUI

struct NotificationView: View {
    
    // MARK: - ENVIRONMENT PROPERTIES
    @Environment(NotificationService.self) private var ns
    
    // MARK: - LOCAL STATE PROPERTIES
    let notification: NotificationMessage
    
    // MARK: - VIEW
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: notification.type.icon)
                .font(.system(size: 44))
                .foregroundStyle(.white)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(notification.title.uppercased())
                    .font(.headline)
                    .fontWeight(.heavy)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Text(notification.message)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
                    .lineLimit(3)
            }
            
            Spacer()
            
            Button {
                ns.hide()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white.opacity(0.8))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(notification.type.color.gradient)
                .shadow(color: .white, radius: 5, x: 0, y: 0)
            )
        .padding(.horizontal, 16)
    }
}

#Preview {
    let notification1 = NotificationMessage(
        type: .info,
        title: "No Results Returned",
        message: "Your query did not return any results. Please try a new search!",
        duration: 4.0
    )
    let notification2 = NotificationMessage(
        type: .error,
        title: "No Network Available",
        message: "Please check your internet connection and try again.",
        duration: 4.0
    )
    let notification3 = NotificationMessage(
        type: .success,
        title: "New Puzzle Added",
        message: "Congratulation! You have added a new puzzle to your library!",
        duration: 3.0
    )
    let notification4 = NotificationMessage(
        type: .warning,
        title: "Possible Duplicate",
        message: "There is another book in your library with this ISBN. Are you sure you want to proceed?",
        duration: 3.0
    )
    
    VStack(spacing: 20) {
        NotificationView(notification: notification1)
        NotificationView(notification: notification2)
        NotificationView(notification: notification3)
        NotificationView(notification: notification4)
    }
    .environment(NotificationService())
    .preferredColorScheme(.dark)
}
