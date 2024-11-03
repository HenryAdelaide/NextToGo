//
//  RaceForm.swift
//  NextToGo
//
//  Created by Henry Liu on 2/11/2024.
//


import Foundation

// MARK: - RaceForm
struct RaceForm: Codable {
    let distance: Int?
    let distanceType: DistanceType?
    let distanceTypeID: String?
    let trackCondition: DistanceType?
    let trackConditionID: String?
    let weather: DistanceType?
    let weatherID: String?
    let raceComment, additionalData: String?
    let generated: Int?
    let silkBaseURL, raceCommentAlternative: String?

    enum CodingKeys: String, CodingKey {
        case distance
        case distanceType = "distance_type"
        case distanceTypeID = "distance_type_id"
        case trackCondition = "track_condition"
        case trackConditionID = "track_condition_id"
        case weather
        case weatherID = "weather_id"
        case raceComment = "race_comment"
        case additionalData = "additional_data"
        case generated
        case silkBaseURL = "silk_base_url"
        case raceCommentAlternative = "race_comment_alternative"
    }
}


// MARK: - DistanceType
struct DistanceType: Codable {
    let id, name: String?
    let shortName: String?
    let iconURI: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case shortName = "short_name"
        case iconURI = "icon_uri"
    }
}
