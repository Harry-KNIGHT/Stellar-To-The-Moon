//
//  LocationManager.swift
//  Stellar
//
//  Created by Elliot Knight on 18/05/2023.
//

import SwiftUI
import CoreLocation

class LocationManager: ObservableObject {
	let manager = CLLocationManager()

	private let locationManager = CLLocationManager()
	
	func askForUserLocation() {
		if CLLocationManager.authorizationStatus() == .notDetermined {
			// Create a CLLocationManager instance

			// Set the desired accuracy and distance filter
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.distanceFilter = kCLDistanceFilterNone

			// Request location authorization
			locationManager.requestWhenInUseAuthorization()
		}
	}
}
