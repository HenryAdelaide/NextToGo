//
//  APIResponse.swift
//  NextToGo
//
//  Created by Henry Liu on 1/11/2024.
//

import Foundation

// MARK: - APIResponse
struct APIResponse: Codable {
    let status: Int
    let data: RaceInfo
    let message: String
}

// MARK: - RaceInfo
struct RaceInfo: Codable {
    let nextToGoIDS: [String]
    let raceSummaries: [String: RaceSummary]

    enum CodingKeys: String, CodingKey {
        case nextToGoIDS = "next_to_go_ids"
        case raceSummaries = "race_summaries"
    }
}
