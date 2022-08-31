//
//  AstronomyArticleApi.swift
//  NasaAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import Foundation
import SwiftUI
import StellarMoonKit

enum ApiError: Error {
	case urlNotFound, dataError, badHttpResponse, someThingWentWrong, noDataForImage
}

class AstronomyApi: ObservableObject {
    @Published public var nasaReponses: [NasaAstronomyResponse] = []

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

            if let decodedResponse = try? JSONDecoder().decode(NasaAstronomyResponse.self, from: data) {
				DispatchQueue.main.async {
					print("Decoded response")
                    self.nasaReponses.append(decodedResponse)
				}
			}
		} catch {
			print("There was an error, \(error.localizedDescription)")
		}
	}

	func getImage(from url: String) async throws -> UIImage {
		guard let url = URL(string: url) else {
			throw ApiError.urlNotFound
		}
		do {
			let (data, _) = try await URLSession.shared.data(from: url)
			if let image = UIImage(data: data) {
				return image
			} else {
				throw ApiError.noDataForImage
			}

		} catch {
			print("Error fetching image: \(error.localizedDescription)")
		}
		return UIImage()
	}
}
