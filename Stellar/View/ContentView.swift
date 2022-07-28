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
			AstronomyArticleList()
				.tabItem {
					Label("Articles", systemImage: "book.closed")
				}

			PersonInSpaceView()
				.tabItem {
					Label("Astronotes", systemImage: "globe.americas")
				}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
