//
//  ContentView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		MainScreen()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(ArticleViewModel())
			.environmentObject(DownloadImageViewModel())
			.environmentObject(SearchDateArticleViewModel())
	}
}
