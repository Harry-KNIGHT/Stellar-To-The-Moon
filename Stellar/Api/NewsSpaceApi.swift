//
//  NewsSpaceApi.swift
//  Stellar
//
//  Created by Elliot Knight on 04/08/2022.
//

import Foundation

class NewsSpaceApi: ObservableObject {
	@Published public var spaceNews = [NewsResponseElement]()

	func fetchSpaceNews() async throws {
		let url = "https://api.spaceflightnewsapi.net/v3/articles?_limit=60"

		guard let url = URL(string: url) else {
			throw ApiError.urlNotFound
		}

		do {
			let (data, response) = try await URLSession.shared.data(from: url)

			guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else { throw ApiError.badHttpResponse }

			if let decodedData = try? JSONDecoder().decode([NewsResponseElement].self, from: data) {
				DispatchQueue.main.async {
					self.spaceNews = decodedData
				}
			}
		}
	}
}
