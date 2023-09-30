//
//  ArticleDetailView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import UIKit
import Domain

struct ArticleDetailView: View {
	public let article: ArticlePresentation

	// MARK: Properties
	@State private var isSheetPresented = false

	@EnvironmentObject var astronomyApi: DownloadImageViewModel
	@State private var isImageDownloaded = false
	@State private var isImageDownloading = false

	// MARK: - Body

	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(spacing: 0) {
				ArticleDetailPhotoView(article: article)

				ArticleDetailBodyView(
					article: article,
					isImageDownloading: $isImageDownloading,
					isImageDownloaded: $isImageDownloaded
				)
				.padding(.horizontal)
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarTitle(article.title)
	}
}

// MARK: - Preview

struct ArticleDetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ArticleDetailView(article: .imageArticleSample)
				.environmentObject(DownloadImageViewModel())
				.environmentObject(FavoriteViewModel())
		}
		NavigationView {
			ArticleDetailView(article: .imageArticleSample)
				.environmentObject(DownloadImageViewModel())
				.environmentObject(FavoriteViewModel())
		}
	}
}
