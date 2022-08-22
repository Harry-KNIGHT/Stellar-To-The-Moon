//
//  AllAstronomyArticlesApi.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import StellarMoonKit

class AstronomiesArticleViewModel: ObservableObject {
	@Published var allAstronomies = [NasaAstronomyResponse]()


	@MainActor func getAstronomiesArticles(from hundredDayBefore: Int64 = Date().millisecondsSince1970 , to today: Date) async throws {
		do {
			allAstronomies = try await AstronomiesArticleApi.fetchAstronomiesObject(from: hundredDayBefore, to: today)
		} catch {
			print("Error \(error.localizedDescription)")
		}
	}
}
