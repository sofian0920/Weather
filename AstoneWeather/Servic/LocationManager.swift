//
//  LoationManager.swift
//  AstoneWeather
//
//  Created by Софья Норина on 11.10.2023.
//

import CoreLocation
import RxSwift
import RxCocoa

class LocationManager: NSObject, CLLocationManagerDelegate {

    static let shared = LocationManager()

    private let locationManager = CLLocationManager()
    private let didUpdateLocationsSubject = PublishSubject<[CLLocation]>()
    private let disposeBag = DisposeBag()

    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    func getLocation() -> Observable<(latitude: Double, longitude: Double)> {
          locationManager.startUpdatingLocation()

          let location = didUpdateLocationsSubject
              .compactMap { $0.last?.coordinate }
              .take(1)
              .flatMap { coordinate -> Observable<(latitude: Double, longitude: Double)> in
                  let lat = coordinate.latitude
                  let lon = coordinate.longitude
                  return Observable.just((latitude: lat, longitude: lon))
              }
              .do(onDispose: { [weak self] in
                  self?.locationManager.stopUpdatingLocation()
              })

          return location
      }
    
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        didUpdateLocationsSubject.onNext(locations)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
