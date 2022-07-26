//
//  AllAstronomiesApi.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI

class AllAstronomiesApi: ObservableObject {
	@Published var allAstronomies = [NasaAstronomyResponse]()


	func fetchAstronomiesObject(to today: Date) async {
		let  today = Date()
		let formatter = DateFormatter()

		formatter.dateFormat = "yyyy-MM-dd"
		let dateString = formatter.string(from: today)
		print(dateString)

		let apiKey: String = "wHAZImKgLhzz4TzarBAWeznXG1TOSiUh3DqnrobZ"
		let url: String = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)&start_date=2022-06-06&end_date=\(dateString)"

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
