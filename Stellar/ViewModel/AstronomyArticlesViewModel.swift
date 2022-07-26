//
//  AllAstronomyArticlesApi.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import StellarMoonKit

class AstronomiesArticleViewModel: ObservableObject {
	@Published var allAstronomies: [AstronomyArticleModel]

	init() {
		if let data = UserDefaults.standard.data(forKey: "SavedData") {
			if let decoded = try? JSONDecoder().decode([AstronomyArticleModel].self, from: data) {
				allAstronomies = decoded
				return
			}
		}
		// No Saved data
		allAstronomies = []
	}

	func save() {
		if let encoded = try? JSONEncoder().encode(allAstronomies) {
			UserDefaults.standard.set(encoded, forKey: "SavedData")
		}
	}

	@MainActor func getAstronomiesArticles(from hundredDayBefore: Int64 = Date().millisecondsSince1970, to today: Date) {
		Task {
			do {
				allAstronomies = try await AstronomiesArticleApi.fetchAstronomiesObject(from: hundredDayBefore, to: today)
				save()
			} catch {
				print("Error \(error.localizedDescription)")
			}
		}
	}
}
