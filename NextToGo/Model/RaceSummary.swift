//
//  RaceSummary.swift
//  NextToGo
//
//  Created by Henry Liu on 2/11/2024.
//
import Foundation

// MARK: - RaceSummary
struct RaceSummary: Codable {
    let raceID, raceName: String
    let raceNumber: Int
    let meetingID, meetingName: String?
    let categoryID: String?
    let advertisedStart: AdvertisedStart
    let raceForm: RaceForm?
    let venueID, venueName, venueState, venueCountry: String?

    enum CodingKeys: String, CodingKey {
        case raceID = "race_id"
        case raceName = "race_name"
        case raceNumber = "race_number"
        case meetingID = "meeting_id"
        case meetingName = "meeting_name"
        case categoryID = "category_id"
        case advertisedStart = "advertised_start"
        case raceForm = "race_form"
        case venueID = "venue_id"
        case venueName = "venue_name"
        case venueState = "venue_state"
        case venueCountry = "venue_country"
    }
}

// MARK: - AdvertisedStart
struct AdvertisedStart: Codable {
    let seconds: Int
}
