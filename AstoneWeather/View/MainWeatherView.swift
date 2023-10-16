//
//  MainWeatherView.swift
//  AstonWeather
//
//  Created by Софья Норина on 10.10.2023.
//

import UIKit

class MainWeatherView: UIView {
    
    // MARK: - UI Elements
    
        private let buttonTopOffset: CGFloat = 100
        private let buttonTrailingOffset: CGFloat = 100
        private let stackViewTopOffset: CGFloat = 150
        private let tempLabelTopOffset: CGFloat = 100
        private let weekViewTopOffset: CGFloat = 100
        private let nextDaysLabelTopOffset: CGFloat = 100
        private let collectionViewTopOffset: CGFloat = 100
        private let collectionViewLeadingOffset: CGFloat = 40
        private let collectionViewTrailingOffset: CGFloat = -40
        private let collectionViewHeight: CGFloat = 90
        private let nextDaysLabelLeadingOffset: CGFloat = 200
        

    
    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(named: "search"), for: .normal)
        return button
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.text = "Date"
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.textAlignment = .center
        label.text = "City"
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.text = "Temperature"
        return label
    }()
    
    private let weekView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let nextDaysLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.textAlignment = .center
        label.text = "Week weather"
        return label
    }()
    
    private lazy var firstLineStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dateLabel, cityLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var weatherTodayCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cvv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cvv.translatesAutoresizingMaskIntoConstraints = false
        return cvv
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Functions
        
    
    func setupViews() {
        addSubview(searchButton)
        addSubview(firstLineStackView)
        addSubview(tempLabel)
        addSubview(weekView)
        weekView.addSubview(nextDaysLabel)
        addSubview(weatherTodayCollectionView)
        weatherTodayCollectionView.register(WeatherViewCell.self, forCellWithReuseIdentifier: WeatherViewCell.identifier)
    }
    
    func setupConstraints() {
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        weekView.translatesAutoresizingMaskIntoConstraints = false
        nextDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLineStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherTodayCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                   
                   searchButton.topAnchor.constraint(equalTo: topAnchor, constant: buttonTopOffset),
                   searchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: buttonTrailingOffset),
                   
                   
                   firstLineStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
                   firstLineStackView.topAnchor.constraint(equalTo: topAnchor, constant: stackViewTopOffset),
                   
                   
                   tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                   tempLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: tempLabelTopOffset),
                   
                   
                   weekView.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: weekViewTopOffset),
                   weekView.widthAnchor.constraint(equalTo: widthAnchor),
                   weekView.bottomAnchor.constraint(equalTo: bottomAnchor),
                  
                 
                   nextDaysLabel.topAnchor.constraint(equalTo: tempLabel.topAnchor, constant: nextDaysLabelTopOffset),
                   nextDaysLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: nextDaysLabelLeadingOffset),
                   
                   
                   weatherTodayCollectionView.topAnchor.constraint(equalTo: nextDaysLabel.bottomAnchor, constant: collectionViewTopOffset),
                   weatherTodayCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: collectionViewLeadingOffset),
                   weatherTodayCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: collectionViewTrailingOffset),
                   weatherTodayCollectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight),
                   weatherTodayCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor)

               ])
    }
    
    // MARK: - Helper Functions
    
    func setUp(with weather: WeatherData?) {
        guard let weather = weather else { return }
        cityLabel.text = weather.name
        tempLabel.text = weather.tempratureString
        dateLabel.text = Converter.shared.currentDate()
    }
    
}
