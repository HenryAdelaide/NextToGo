//
//  ViewController.swift
//  NextToGo
//
//  Created by Henry Liu on 30/10/2024.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    /// RaceSummaries will be used as source of truth to categorize races every time when it's updated
    var raceSummaries: [RaceSummary] = [] {
        didSet {
            greyhoundRaces = raceSummaries.filter({ $0.categoryID == Category.greyhound.rawValue }).sorted(by: { $0.advertisedStart.seconds < $1.advertisedStart.seconds })
            harnessRaces = raceSummaries.filter({ $0.categoryID == Category.harness.rawValue }).sorted(by: { $0.advertisedStart.seconds < $1.advertisedStart.seconds })
            horseRaces = raceSummaries.filter({ $0.categoryID == Category.horse.rawValue }).sorted(by: { $0.advertisedStart.seconds < $1.advertisedStart.seconds })
        }
    }
    
    /// Categories to store selected filters, once all filters are deselected, it will call function getRaces of ViewModel to fetch new data
    var categories: [Category] = [] {
        didSet {
            if categories.isEmpty {
                activityAnimator.startAnimating()
                viewModel.getRaces { [weak self] in
                    self?.activityAnimator.stopAnimating()
                }
            } else {
                tableView.reloadData()
            }
        }
    }
    
    var greyhoundRaces: [RaceSummary] = []
    var harnessRaces: [RaceSummary] = []
    var horseRaces: [RaceSummary] = []
    
    let viewModel: RaceViewModel = .init()
    var cancellables: Set<AnyCancellable> = []
    
    private lazy var activityAnimator: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        view.addSubview(indicatorView)
        indicatorView.center = view.center
        return indicatorView
    }()
    
    private lazy var categoryFilter: CategoryFilterView
     = CategoryFilterView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
        fetchRaceSummaries()
        viewModel.bindCategoryButtonPubliser(greyHoundPublisher: categoryFilter.greyhoundPublisher, harnessPublisher: categoryFilter.harnessPublisher, horsePublisher: categoryFilter.horsePublisher)
        filterRacesByCategory()
        viewModel.createTimerToRefresh { [weak self] in
            self?.viewModel.getRaces()
        }
    }
    
    /// Set up UI on ViewController
    private func setUp() {
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .lightGray
        tableView.register(RaceTableViewCell.loadNib, forCellReuseIdentifier: RaceTableViewCell.reuseId)
        tableView.tableHeaderView = categoryFilter
    }
    
    /// Update UI when new Races arrive
    private func fetchRaceSummaries() {
        viewModel.$racesSummaries.sink { [weak self] summaries in
            self?.raceSummaries = summaries
            self?.tableView.reloadData()
        }.store(in: &cancellables)
    }
    
    /// Update UI when Category Filters are selected and deselected
    private func filterRacesByCategory() {
        viewModel.$categoryFilter.sink { [unowned self] categories in
            self.categories = categories
        }.store(in: &cancellables)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if categories.isEmpty {
            return 1
        }
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categories.isEmpty {
            return raceSummaries.count
        }
        let category = categories[section]
        switch category {
        case .greyhound:
            return greyhoundRaces.count
        case .harness:
            return harnessRaces.count
        case .horse:
            return horseRaces.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if categories.isEmpty {
            let raceSummary = raceSummaries[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: RaceTableViewCell.reuseId) as? RaceTableViewCell {
                cell.configure(with: raceSummary)
                return cell
            }
        } else {
            let category = categories[indexPath.section]
            if let cell = tableView.dequeueReusableCell(withIdentifier: RaceTableViewCell.reuseId) as? RaceTableViewCell {
                var raceSummary: RaceSummary
                switch category {
                case .greyhound:
                    raceSummary = greyhoundRaces[indexPath.row]
                case .harness:
                    raceSummary = harnessRaces[indexPath.row]
                case .horse:
                    raceSummary = horseRaces[indexPath.row]
                }
                cell.configure(with: raceSummary)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if categories.isEmpty {
            return "Next To Go Races"
        }
        let category = categories[section]
        switch category {
        case .greyhound:
            return "Greyhound"
        case .harness:
            return "Harness"
        case .horse:
            return "Horse"
        }
    }
}

