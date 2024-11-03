//
//  DateFormatter+Extension.swift
//  NextToGo
//
//  Created by Henry Liu on 3/11/2024.
//

import Foundation

extension DateFormatter {
    
    /// Transform Timestamp to a formatted String
    /// - Parameter timestamp: TimeStamp
    /// - Returns: Formatted String
    func formattedString(timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        self.dateFormat = "dd/MM/yyyy hh:mm a"
        return self.string(from: date)
    }
}
