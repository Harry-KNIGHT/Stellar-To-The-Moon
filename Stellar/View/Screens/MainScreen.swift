//
//  AstronomyImageGrid.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import ActivityIndicatorView


struct MainScreen: View {
	@EnvironmentObject public var articleVm: AstronomiesArticleViewModel
	@State private var showFavoritesSheet = false
	@State private var showLoadingIndicator = true
	@State private var showBirthdayPicker = false

	var body: some View {
		NavigationView {
			VStack {
				if articleVm.allAstronomies.isEmpty {
					LoadingView()
				} else {
					ArticlesGridView(showFavoritesSheet: $showFavoritesSheet, showBirthdayPicker: $showBirthdayPicker)
				}
			}
			.navigationTitle("Stellar")
			.navigationBarTitleDisplayMode(.inline)
			.onAppear {
				Task {
					articleVm.getAstronomiesArticles(to: Date.now)
				}
			}
		}
	}
}

struct AstronomyImageGrid_Previews: PreviewProvider {
	static var previews: some View {
		MainScreen()
			.environmentObject(AstronomiesArticleViewModel())
	}
}
