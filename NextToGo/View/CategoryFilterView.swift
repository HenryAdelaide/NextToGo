//
//  CategoryFilterView.swift
//  NextToGo
//
//  Created by Henry Liu on 2/11/2024.
//

import UIKit
import Combine

/**
    Hosts Three Category Filters in CategoryFilterView, wrapped in a UIStackView, used as HeaderView of UITableView
 */
class CategoryFilterView: UIView {

    private let greyhoundSubject: PassthroughSubject<Category, Never> = PassthroughSubject()
    var greyhoundPublisher: AnyPublisher<Category, Never> { greyhoundSubject.eraseToAnyPublisher()}
    
    private let harnessSubject: PassthroughSubject<Category, Never> = PassthroughSubject()
    var harnessPublisher: AnyPublisher<Category, Never> { harnessSubject.eraseToAnyPublisher()}
    
    private let horseSubject: PassthroughSubject<Category, Never> = PassthroughSubject()
    var horsePublisher: AnyPublisher<Category, Never> { horseSubject.eraseToAnyPublisher()}
    
    private lazy var greyhoundButton: UIButton = {
        let button = buildCategoryButton(category: .greyhound)
        button.addTarget(self, action: #selector(tapGreyhoundCategoryButton), for: .touchUpInside)
        button.accessibilityTraits = .button
        button.accessibilityIdentifier = AccesibilityManager.GreyhoundCategory.accessibilityIdentifier
        button.accessibilityLabel = AccesibilityManager.GreyhoundCategory.accessibilityLabel
        button.accessibilityHint = AccesibilityManager.GreyhoundCategory.accessibilityHint
        return button
    }()
    
    private lazy var harnessButton: UIButton = {
        let button = buildCategoryButton(category: .harness)
        button.addTarget(self, action: #selector(tapHarnessCategoryButton), for: .touchUpInside)
        button.accessibilityTraits = .button
        button.accessibilityIdentifier = AccesibilityManager.HarnessCategory.accessibilityIdentifier
        button.accessibilityLabel = AccesibilityManager.HarnessCategory.accessibilityLabel
        button.accessibilityHint = AccesibilityManager.HarnessCategory.accessibilityHint
        return button
    }()
    
    private lazy var horseButton: UIButton = {
        let button = buildCategoryButton(category: .horse)
        button.addTarget(self, action: #selector(tapHorseCategoryButton), for: .touchUpInside)
        button.accessibilityTraits = .button
        button.accessibilityIdentifier = AccesibilityManager.HorseCategory.accessibilityIdentifier
        button.accessibilityLabel = AccesibilityManager.HorseCategory.accessibilityLabel
        button.accessibilityHint = AccesibilityManager.HorseCategory.accessibilityHint
        return button
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [greyhoundButton, harnessButton, horseButton])
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        backgroundColor = .white
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            hStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            hStackView.topAnchor.constraint(equalTo: topAnchor),
            hStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    /// Factory function to create button
    private func buildCategoryButton(category: Category) -> UIButton {
        let button = UIButton(type: .custom)
        var title = ""
        switch category {
        case .greyhound:
            title = "Greyhound"
        case .harness:
            title = "Harness"
        case .horse:
            title = "Horse"
        }
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        button.backgroundColor = UIColor.systemGray
        button.bounds.size = CGSize(width: 50, height: 30)
        button.layer.cornerRadius = 15
        button.isSelected = false
        button.isEnabled = true
        return button
    }
    
    @objc func tapGreyhoundCategoryButton(_ sender: UIButton) {
        greyhoundSubject.send(.greyhound)
        greyhoundButton.isSelected = !greyhoundButton.isSelected
        if greyhoundButton.isSelected {
            greyhoundButton.backgroundColor = .systemOrange
        } else {
            greyhoundButton.backgroundColor = .systemGray
        }
    }
    
    @objc func tapHarnessCategoryButton(_ sender: UIButton) {
        harnessSubject.send(.harness)
        harnessButton.isSelected = !harnessButton.isSelected
        if harnessButton.isSelected {
            harnessButton.backgroundColor = .systemOrange
        } else {
            harnessButton.backgroundColor = .systemGray
        }
    }
    
    @objc func tapHorseCategoryButton(_ sender: UIButton) {
        horseSubject.send(.horse)
        horseButton.isSelected = !horseButton.isSelected
        if horseButton.isSelected {
            horseButton.backgroundColor = .systemOrange
        } else {
            horseButton.backgroundColor = .systemGray
        }
    }
}
