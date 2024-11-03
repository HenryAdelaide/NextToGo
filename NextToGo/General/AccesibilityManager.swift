//
//  AccesibilityManager.swift
//  NextToGo
//
//  Created by Henry Liu on 3/11/2024.
//

import Foundation

/// This Struct is used to manage Accesibility attributes globally
struct AccesibilityManager {
    
    /// Greyhound Category Filter Accesibility Attributes
    struct GreyhoundCategory {
        static let accessibilityIdentifier = "Greyhound"
        static let accessibilityLabel = "Show all greyhound races"
        static let accessibilityHint = "Double Tap to filter by greyhound races"
    }
    
    /// Harness Category Filter Accesibility Attributes
    struct HarnessCategory {
        static let accessibilityIdentifier = "Harness"
        static let accessibilityLabel = "Show all harness races"
        static let accessibilityHint = "Double Tap to filter by harness races"
    }
    
    /// Horse Category Filter Accesibility Attributes
    struct HorseCategory {
        static let accessibilityIdentifier = "Horse"
        static let accessibilityLabel = "Show all horse races"
        static let accessibilityHint = "Double Tap to filter by horse races"
    }
}
