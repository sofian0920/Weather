//
//  ViewController.swift
//  AstoneWeather
//
//  Created by Софья Норина on 10.10.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import CoreLocation

class ViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let viewModel: WeatherViewModel
    private let mainWeatherView = MainWeatherView()
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    
    func setUpView() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mainWeatherView)
        view.addSubview(mainWeatherView)
        mainWeatherView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension  ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell
        
        cell.configure(with: WeatherData )
    }
    
    func
}

