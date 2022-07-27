//
//  AllAstronomiesApi.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI

class AllAstronomiesApi: ObservableObject {
	@Published var allAstronomies = [NasaAstronomyResponse]()

	func fetchAstronomiesObject(from hundredDayBefore: Int64 = Date().millisecondsSince1970 , to today: Date) async {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"

		//100 days ago converter
		let epochHundredDaysAgo: Int64 = 5184000000 // 60 days in milliseconds
		let todayMinusHundredDay = (hundredDayBefore - epochHundredDaysAgo)
		let hundredDayAgoDateType = Date(milliseconds: todayMinusHundredDay)
		let hundredDayAgo = formatter.string(from: hundredDayAgoDateType)

		// Today time converter
		let  today = Date()

		let dateString = formatter.string(from: today)
		print(dateString)



		let apiKey: String = "wHAZImKgLhzz4TzarBAWeznXG1TOSiUh3DqnrobZ"
		let url: String = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)&start_date=\(hundredDayAgo)&end_date=\(dateString)"

		guard let url = URL(string: url) else {
			return
		}


		do {
			let (data, response) = try await URLSession.shared.data(from: url)

			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
				print("Http response out of bounds \(response)")
				return
			}

			if let decodedResponse = try? JSONDecoder().decode([NasaAstronomyResponse].self, from: data) {
				DispatchQueue.main.async {
					self.allAstronomies = decodedResponse
				}
			}
		} catch {
			print("Something wrong append")
		}
	}
}


extension Date {
	var millisecondsSince1970: Int64 {
		Int64((self.timeIntervalSince1970 * 1000.0).rounded())
	}

	init(milliseconds: Int64) {
		self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
	}
}
