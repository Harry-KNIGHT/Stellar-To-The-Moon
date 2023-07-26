//
//  NasaDayAstronomyApp.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI

@main
struct NasaDayAstronomyApp: App {
	@StateObject var astronomyVM = DownloadImageViewModel()
	@StateObject var favoriteVM = FavoriteViewModel()

	var body: some Scene {
		WindowGroup {
				MainScreen()
					.environmentObject(astronomyVM)
					.environmentObject(favoriteVM)
		}
	}
}
