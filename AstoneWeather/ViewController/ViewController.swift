//
//  ViewController.swift
//  AstoneWeather
//
//  Created by Софья Норина on 10.10.2023.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private var viewModel: WeatherViewModelProtocol
    private var weatherView = MainWeatherView()
    private var locationManager = CLLocationManager()
    
    
    // MARK: - Initialization
    
    init(viewModel: WeatherViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.weatherData
            .compactMap { $0 }
            .observeOn( MainScheduler.instance)
            .subscribe { [weak self] weatherData in
                self?.weatherView.setUp(with: weatherData)
            }.disposed(by: disposeBag)
        
        self.viewModel.nextWeekData
            .compactMap { $0 }
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.weatherView.weatherTodayCollectionView.reloadData()
            }.disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
            weatherView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
            setupLocationManager()
            bindView()
        }
    // MARK: - Setup Functions
        
    func setupViews() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: weatherView.searchButton)
            view.addSubview(weatherView)
            weatherView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                weatherView.topAnchor.constraint(equalTo: view.topAnchor),
                weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    
    // MARK: - Action
    
        @objc private func searchButtonTapped() {
            let searchViewController = SearchViewController(viewModel: viewModel as! WeatherViewModel)
            let navigationController = UINavigationController(rootViewController: searchViewController)
            present(navigationController, animated: true, completion: nil)
        }
    
    // MARK: - Data Binding
    
        func bindView() {
            weatherView.weatherTodayCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
            viewModel.nextWeekData
                .map { $0?.nextWeekArray ?? [] }
                .asDriver(onErrorJustReturn: [])
                .drive(weatherView.weatherTodayCollectionView.rx.items(cellIdentifier: WeatherViewCell.identifier, cellType: WeatherViewCell.self)) { (_, weatherWeekModel, cell) in
                    cell.configureWeekWeather(with: weatherWeekModel)
                }.disposed(by: disposeBag)
        }
        
    // MARK: - Location Manager

    
    func setupLocationManager() {
        LocationManager.shared.getCurrentLocation()
            .subscribe(onNext: { [weak self] location in
                self?.viewModel.fetchWeatherWithLocation(latitude: location.latitude, longitude: location.longitude)
                self?.viewModel.fetchWeekWeatherWithLocation(latitude: location.latitude, longitude: location.longitude)
            }, onError: { error in
                print("Location error: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
}
    // MARK: - UICollectionViewDelegateFlowLayout
    extension ViewController: UICollectionViewDelegateFlowLayout {
           
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 7
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            let edgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            return edgeInsets
        }
    }


