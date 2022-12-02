//
//  AstronomyImageGrid.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import ActivityIndicatorView


struct MainScreen: View {
	@EnvironmentObject public var articleApi: AstronomiesArticleViewModel
	@State private var showSheet = false
	@State private var showLoadingIndicator = true

	var body: some View {
		NavigationView {
			VStack {
				if articleApi.allAstronomies.isEmpty {
					LoadingView()
				} else {
					ArticlesGridView(showSheet: $showSheet)
				}
			}
			.navigationTitle("Stellar")
			.navigationBarTitleDisplayMode(.inline)
			.onAppear {
				Task {
					articleApi.getAstronomiesArticles(to: Date.now)
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
