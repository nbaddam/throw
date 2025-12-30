//
//  Date-ext.swift
//  throw
//
//  Created by Nitya Baddam on 11/24/25.
//

import Foundation

extension Date {
    
    func formattedForDisplay() -> String {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute, .hour], from: self, to: now)
        
        // check if its as recent as 9 hours ago
        if let hours = components.hour, hours < 10 {
            // hours == 0, use minutes
            if hours == 0 {
                if let minutes = components.minute {
                    if minutes == 0 {
                        return "just now"
                    }
                    if minutes == 1 {
                        return "1 minute ago"
                    }
                    else {
                        return "\(minutes) minutes ago"
                    }
                }
            // hours > 0, use hours
            } else {
                if hours == 1 {
                    return "1 hour ago"
                } else {
                    return "\(hours) hours ago"
                }
            }
        }
        
        // check if it's from the current year
        let currentYear = calendar.component(.year, from: now)
        let dateYear = calendar.component(.year, from: self)
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        
        if dateYear == currentYear {
            formatter.dateFormat = "MMMM d" // "August 2"
        } else {
            formatter.dateFormat = "MMMM d, yyyy" // "August 2, 2024"
        }
        
        return formatter.string(from: self)
    }
    
    static func getRandomDate() -> Date {
        let currentDateTime = Date()
        let week = 604800.00
        let randNumber = Double.random(in: 0..<5)
        
        return Date(timeInterval: -(randNumber*week), since: currentDateTime)
    }
}
