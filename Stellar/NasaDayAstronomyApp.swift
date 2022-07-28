//
//  NasaDayAstronomyApp.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI

@main
struct NasaDayAstronomyApp: App {
	@StateObject var astronomyApi = AstronomyApi()
	@StateObject var allAstronomiesApi = AstronomiesArticleApi()
	@StateObject var favoriteVM = FavoriteViewModel()
	@StateObject var spacePeoples = PersonInSpaceApi()
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(astronomyApi)
				.environmentObject(allAstronomiesApi)
				.environmentObject(favoriteVM)
				.environmentObject(spacePeoples)
        }
    }
}
