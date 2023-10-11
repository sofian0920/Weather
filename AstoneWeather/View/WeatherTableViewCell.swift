//
//  WeatherTableViewCell.swift
//  AstoneWeather
//
//  Created by Софья Норина on 10.10.2023.
//

import UIKit
import SnapKit

class WeatherTableViewCell: UITableViewCell {
    static let identifier = "WeatherTableViewCell"
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    

        private let borderView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 17
            return view
        }()

//        private let imageView: UIImageView = {
//            let imageView = UIImageView()
//            return imageView
//        }()

        private let tempLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
            setupConstraints()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupViews() {
            contentView.addSubview(dayLabel)
            contentView.addSubview(borderView)
//            contentView.addSubview(imageView)
            contentView.addSubview(tempLabel)
        }

        private func setupConstraints() {
            dayLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(10)
            }

            borderView.snp.makeConstraints { make in
                make.top.equalTo(dayLabel.snp.bottom).offset(3)
                make.width.equalToSuperview()
                make.leading.equalToSuperview()
                make.bottom.equalToSuperview()
            }

//            imageView.snp.makeConstraints { make in
//                make.top.equalTo(borderView.snp.top).offset(10)
//                make.height.equalTo(26)
//                make.width.equalTo(26)
//                make.centerX.equalToSuperview()
//            }

            tempLabel.snp.makeConstraints { make in
//                make.top.equalTo(imageView.snp.bottom).offset(4)
                make.centerX.equalToSuperview()
            }
        }
    
}
