//
//  LocationManager.swift
//  Stellar
//
//  Created by Elliot Knight on 18/05/2023.
//

import CoreLocation

class LocationManager: ObservableObject {
	private let locationManager = CLLocationManager()

	func askUserLocation() {
		if locationManager.authorizationStatus == .notDetermined {
			// Set the desired accuracy and distance filter
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.distanceFilter = kCLDistanceFilterNone

			// Request location authorization
			locationManager.requestWhenInUseAuthorization()
		}
	}
}
