//
//  NasaDayAstronomyApp.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI

@main
struct NasaDayAstronomyApp: App {
	@StateObject var astronomyVM = AstronomyDetailViewModel()
	@StateObject var allAstronomiesVM = AstronomiesArticleViewModel()
	@StateObject var favoriteVM = FavoriteViewModel()
	@StateObject var personInSpaceVM = PersonInSpaceViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(astronomyVM)
				.environmentObject(allAstronomiesVM)
				.environmentObject(favoriteVM)
				.environmentObject(personInSpaceVM)
        }
    }
}
