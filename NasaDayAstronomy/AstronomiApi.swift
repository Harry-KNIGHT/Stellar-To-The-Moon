//
//  AstronomiApi.swift
//  NasaAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import Foundation

class AstronomiApi: ObservableObject {
	@Published public var nasaReponses = [NasaAstronomyResponse]()
	
	enum ApiError: Error {
		case urlNotFound, dataError, badHttpResponse
	}

	func nasaApiCall() async throws {
		let url = "https://api.nasa.gov/planetary/apod?api_key=wHAZImKgLhzz4TzarBAWeznXG1TOSiUh3DqnrobZ"
		guard let url = URL(string: url) else {
			print(ApiError.urlNotFound)
			return
		}
		
		do {
			let (data, response) = try await URLSession.shared.data(from: url)

			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
				print(ApiError.badHttpResponse)
				return
			}

			if let decodedResponse = try? JSONDecoder().decode([NasaAstronomyResponse].self, from: data) {
				DispatchQueue.main.async {
					print("Decoded response")
					self.nasaReponses = decodedResponse
				}
			}
		} catch {
			print("There was an error, \(error.localizedDescription)")
		}
	}
}
