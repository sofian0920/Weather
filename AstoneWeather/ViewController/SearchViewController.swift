//
//  SearchViewController.swift
//  AstoneWeather
//
//  Created by Софья Норина on 13.10.2023.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    // MARK: - Properties
    
    private var viewModel: WeatherViewModel
    private var serchView: SearchView
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Initialization
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        self.serchView = SearchView() // Initialize serchView here
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tappedSearchButton() // Fixed typo in the function name
    }
    
    // MARK: - User Interaction
    
    func tappedSearchButton() {
        serchView.serchButton.rx.tap.withLatestFrom(serchView.searchTextField.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] city in
                self?.viewModel.fetchWeatherData(city: city)
                self?.viewModel.fetchWeatherWeekData(city: city)
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - UI Setup
    
    func setupUI() {
        serchView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(serchView)
        
        NSLayoutConstraint.activate([
            serchView.topAnchor.constraint(equalTo: view.topAnchor),
            serchView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            serchView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            serchView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
