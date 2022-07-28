//
//  PeopleInSpaceApi.swift
//  Stellar
//
//  Created by Elliot Knight on 28/07/2022.
//

import Foundation

class PersonInSpaceApi: ObservableObject {
	@Published public var spacePeoples: [PeopleInSpaceResponse] = []

	func fetchPersonInSpace() async throws {
		let url = "https://corquaid.github.io/international-space-station-APIs/JSON/people-in-space.json"

		guard let url = URL(string: url) else {
			throw ApiError.urlNotFound
		}
		do {
			let (data, response) = try await URLSession.shared.data(from: url)

			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 else {
				throw ApiError.badHttpResponse
			}

			if let decodedResponse = try? JSONDecoder().decode(PeopleInSpaceResponse.self, from: data) {
				DispatchQueue.main.async {
					self.spacePeoples.append(decodedResponse)
				}
			}
		} catch {
			print("Error fetching people in space: \(error.localizedDescription)")
			throw ApiError.someThingWentWrong
		}
	}
}
