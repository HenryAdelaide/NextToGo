//
//  RaceViewModel.swift
//  NextToGo
//
//  Created by Henry Liu on 2/11/2024.
//

import Foundation
import Combine

class RaceViewModel: ObservableObject {
    
    let service: RaceAPIServiceProtocol
    
    // Dependency Injection ot inject Service
    init(service: RaceAPIServiceProtocol = RaceAPIService()) {
        self.service = service
    }
    
    @Published var racesSummaries: [RaceSummary] = []
    @Published var categoryFilter: [Category] = []
    
    var cancellables: Set<AnyCancellable> = []
    
    /// Make API Call to fetch races from server
    /// - Parameter completion: will be executed after response comes back
    func getRaces(completion: (() -> Void)? = nil) {
        service.fetchRaces().map { response in
            let raceIDs = response.data.nextToGoIDS
            var raceSummaries = [RaceSummary]()
            for raceId in raceIDs {
                if let raceSummary = response.data.raceSummaries[raceId] {
                    raceSummaries.append(raceSummary)
                }
            }
            raceSummaries.sort(by: { $0.advertisedStart.seconds < $1.advertisedStart.seconds } )
            return raceSummaries
        }.sink(receiveCompletion: { error in
            completion?()
        }, receiveValue: { [weak self] (summaries: [RaceSummary]) in
            self?.racesSummaries = summaries
            completion?()
        }).store(in: &cancellables)
    }
    
    /// Bind Publishers of Three Category Filters
    /// - Parameters:
    ///   - greyHoundPublisher: Greyhound Category Publisher
    ///   - harnessPublisher: Harness Category Publisher
    ///   - horsePublisher: Horse Category Publisher
    func bindCategoryButtonPubliser(greyHoundPublisher: AnyPublisher<Category, Never>, harnessPublisher: AnyPublisher<Category, Never>, horsePublisher: AnyPublisher<Category, Never>) {
        greyHoundPublisher.sink { [unowned self] category in
            self.updateCategoryFilter(category: category)
        }.store(in: &cancellables)
        
        harnessPublisher.sink { [unowned self] category in
            self.updateCategoryFilter(category: category)
        }.store(in: &cancellables)
        
        horsePublisher.sink { [unowned self] category in
            self.updateCategoryFilter(category: category)
        }.store(in: &cancellables)
    }
    
    /// Update Categories status when one of three is selected or deselected
    /// - Parameter category: Enum case of Category
    func updateCategoryFilter(category: Category) {
        if categoryFilter.contains(category) {
            categoryFilter.removeAll { $0 == category }
        } else {
            categoryFilter.append(category)
        }
    }
    
    
    /// Refresh data every minute
    /// - Parameter completion: will be executed once it reaches the interval
    func createTimerToRefresh(completion: (() -> Void)? = nil) {
        Timer.publish(every: 60, on: .main, in: .common).autoconnect().sink {_ in
            completion?()
        }.store(in: &cancellables)
    }
}
