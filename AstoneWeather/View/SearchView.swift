//
//  SearchView.swift
//  AstoneWeather
//
//  Created by Софья Норина on 15.10.2023.
//


import UIKit


class SearchView: UIView {
    // MARK: - UI Elements
    
    private let textFieldWidthRatio: CGFloat = 300 / 414
    private let textFieldHeightRatio: CGFloat = 50 / 896
    private let textFieldTopOffsetRatio: CGFloat = 100 / 896
    private let buttonTopOffsetRatio: CGFloat = 30 / 896
    private let buttonHeightRatio: CGFloat = 30 / 896
    private let buttonWidthRatio: CGFloat = 150 / 414
    
    let whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        return view
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Saerch Location"
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.textColor = .black
        return textField
    }()
    let serchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.backgroundColor = .blue
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Initialization
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Functions
    
    private func setupUI() {
        addSubview(whiteView)
        addSubview(searchTextField)
        addSubview(serchButton)
    }
    
    private func setupConstraints() {
            whiteView.translatesAutoresizingMaskIntoConstraints = false
            searchTextField.translatesAutoresizingMaskIntoConstraints = false
            serchButton.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            
                    whiteView.topAnchor.constraint(equalTo: self.topAnchor),
                    whiteView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                    whiteView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                    whiteView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                   
                    searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * textFieldTopOffsetRatio),
                    searchTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
                    searchTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * textFieldWidthRatio),
                    searchTextField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * textFieldHeightRatio),
                    
                    
                    serchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: UIScreen.main.bounds.height * buttonTopOffsetRatio),
                    serchButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                    serchButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * buttonWidthRatio),
                    serchButton.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * buttonHeightRatio)
                ])
        }
}
