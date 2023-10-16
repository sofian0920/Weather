//
//  WeatherTableViewCell.swift
//  AstoneWeather
//
//  Created by Софья Норина on 10.10.2023.
//

import UIKit


class WeatherViewCell: UICollectionViewCell {
    static let identifier = "WeatherViewCell"
    
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        return label
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureWeekWeather(with weekWeather: WeatherWeekModel) {
         dayLabel.text = weekWeather.day
         tempLabel.text = weekWeather.temp
     }
    
    private func setupUI() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(tempLabel)
    }
    
    private func setupConstraints() {
               dayLabel.translatesAutoresizingMaskIntoConstraints = false
               tempLabel.translatesAutoresizingMaskIntoConstraints = false

               NSLayoutConstraint.activate([
                   dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                   dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),


                   tempLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 4),
                   tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
               ])
    }
    

}
    
   
