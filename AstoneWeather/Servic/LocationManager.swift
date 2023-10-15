//
//  LoationManager.swift
//  AstoneWeather
//
//  Created by Софья Норина on 11.10.2023.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private let updateLocation = PublishSubject<CLLocation?>()
    private let disposeBag = DisposeBag()
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocation() -> Observable<CLLocation?> {
        locationManager.startUpdatingLocation()
        
        let location = updateLocation
            .take(1)
            .do(onDispose: { [weak self] in
                self?.locationManager.stopUpdatingLocation()
            })
        return location
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            updateLocation.onNext(lastLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        updateLocation.onError(error)
    }
}
