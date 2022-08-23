//
//  AstronomyDetailView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import UIKit
import ActivityIndicatorView
import StellarMoonKit

struct AstronomyDetailView: View {
	let article: NasaAstronomyResponse
	@State private var isSheetPresented = false
	@EnvironmentObject var favoriteVM: FavoriteViewModel
	@EnvironmentObject var astronomyApi: AstronomyDetailViewModel

	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
				if article.mediaType == "image" {
					AstronomyImageView(astronomy: article)
				} else {
					VideoView(videoID: article.url)
						.frame(minHeight: 450, maxHeight: 800)
				}
				VStack(alignment: .leading, spacing: 10) {
					Text("Explanation:")
						.font(.headline)
					Text(article.explanation)
						.textSelection(.enabled)
				}
				.padding()
				.background(.thinMaterial)
				.clipShape(RoundedRectangle(cornerRadius: 10))

		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarTitle(article.title)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {
					favoriteVM.addOrDeletFavorite(article: article)
				}, label: {
					Label("Add article to favorite", systemImage: favoriteVM.favoriteAstronomyArticles.contains(article) ? "star.fill" : "star")
						.foregroundColor(.primary)
						.font(.title3)
				})
			}
		}
	}
}

struct AstronomyDetailView_Previews: PreviewProvider {
	static var previews: some View {
		AstronomyDetailView(article: .astronomySample)
			.environmentObject(AstronomyDetailViewModel())
			.environmentObject(FavoriteViewModel())
	}
}
