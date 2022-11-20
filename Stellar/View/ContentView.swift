//
//  ContentView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		TabView {
			AstronomyImageGrid()
				.tabItem {
					Label("Articles", systemImage: "book.closed")
						.accessibilityLabel("Articles")
				}

			IssLiveView()
				.tabItem {
					Label("Iss Live", systemImage: "play.circle")
						.accessibilityLabel("International Space Station live video.")
				}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(AstronomiesArticleViewModel())
			.environmentObject(AstronomyDetailViewModel())
	}
}
