//
//  NasaDayAstronomyApp.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI

@main
struct NasaDayAstronomyApp: App {
	@StateObject var astronomyApi = AstronomiApi()
	@StateObject var allAstronomiesApi = AllAstronomiesApi()
	@StateObject var favoriteVM = FavoriteViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(astronomyApi)
				.environmentObject(allAstronomiesApi)
				.environmentObject(favoriteVM)
        }
    }
}
