//
//  NextToGoTests.swift
//  NextToGoTests
//
//  Created by Henry Liu on 30/10/2024.
//

import XCTest
import Combine
@testable import NextToGo

final class NextToGoTests: XCTestCase {

    private var viewModel: RaceViewModel!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        viewModel = RaceViewModel(service: MockRaceAPIServiceProtocol())
        cancellables = .init()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        cancellables = nil
    }
    
    func testGetRaces() {
        viewModel.getRaces()
        
        viewModel.$racesSummaries.sink { summaires in
            XCTAssertEqual(summaires.count, 3)
            XCTAssertEqual(summaires[0].meetingName, "Remington Park")
            XCTAssertEqual(summaires[1].meetingName, "Woodbine Mohawk Park")
            XCTAssertEqual(summaires[2].meetingName, "Mount Gambier")
        }.store(in: &cancellables)
    }
    
    func testCategoryButtonPublishers() throws {
        let greyhoundSubject = PassthroughSubject<NextToGo.Category, Never>()
        let harnessSubject = PassthroughSubject<NextToGo.Category, Never>()
        let horseSubject = PassthroughSubject<NextToGo.Category, Never>()
        
        viewModel.bindCategoryButtonPubliser(greyHoundPublisher: greyhoundSubject.eraseToAnyPublisher(), harnessPublisher: harnessSubject.eraseToAnyPublisher(), horsePublisher: horseSubject.eraseToAnyPublisher())
        
        greyhoundSubject.send(.greyhound)
        
        let first = try XCTUnwrap(viewModel.categoryFilter.first)
        XCTAssertTrue(first == .greyhound)
        
        harnessSubject.send(.harness)
        XCTAssertEqual(viewModel.categoryFilter[1], .harness)
        
        horseSubject.send(.horse)
        XCTAssertEqual(viewModel.categoryFilter[2], .horse)
        
        greyhoundSubject.send(.greyhound)
        XCTAssertFalse(viewModel.categoryFilter.contains(.greyhound))
    }
    
    func testCreateTimer() {
        let expectation = XCTestExpectation(description: "Timer has been triggered")
        viewModel.createTimerToRefresh {
            self.wait(for: [expectation], timeout: 65)
        }
    }
}

class MockRaceAPIServiceProtocol: RaceAPIServiceProtocol {
    func fetchRaces() -> AnyPublisher<NextToGo.APIResponse, any Error> {
        let apiResponse = APIResponse(
            status: 200,
            data: RaceInfo(
                nextToGoIDS: ["100fae80-2b39-4d22-8fae-7e6cd9488d7f", "9eb656a8-5962-4cb9-9839-079cabff3307", "9dde63b6-bff3-4b00-af28-cc03bbc82e27"],
                raceSummaries: [
                    "100fae80-2b39-4d22-8fae-7e6cd9488d7f" : RaceSummary(raceID: "100fae80-2b39-4d22-8fae-7e6cd9488d7f", raceName: "Race 6 - Claiming", raceNumber: 6, meetingID: nil, meetingName: "Remington Park", categoryID: "4a2788f8-e825-4d36-9894-efd4baf1cfae", advertisedStart: AdvertisedStart(seconds: 1730599140), raceForm: nil, venueID: nil, venueName: nil, venueState: nil, venueCountry: nil),
                    "9dde63b6-bff3-4b00-af28-cc03bbc82e27" : RaceSummary(raceID: "9dde63b6-bff3-4b00-af28-cc03bbc82e27", raceName: "RGreg Martlew Autos Maiden Stake Pr1 Division1", raceNumber: 2, meetingID: nil, meetingName: "Mount Gambier", categoryID: "9daef0d7-bf3c-4f50-921d-8e818c60fe61", advertisedStart: AdvertisedStart(seconds: 1730599440), raceForm: nil, venueID: nil, venueName: nil, venueState: nil, venueCountry: nil),
                    "9eb656a8-5962-4cb9-9839-079cabff3307" : RaceSummary(raceID: "9eb656a8-5962-4cb9-9839-079cabff3307", raceName: "Race 8 - 1609M", raceNumber: 8, meetingID: nil, meetingName: "Woodbine Mohawk Park", categoryID: "161d9be2-e909-4326-8c2c-35ed71fb460b", advertisedStart: AdvertisedStart(seconds: 1730599260), raceForm: nil, venueID: nil, venueName: nil, venueState: nil, venueCountry: nil)
                ]
            ),
            message: "Test Purpose"
        )
        
        return Just(apiResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
