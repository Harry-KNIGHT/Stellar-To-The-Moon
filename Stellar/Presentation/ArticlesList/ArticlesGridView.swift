//
//  ArticlesGridView.swift
//  Stellar
//
//  Created by Elliot Knight on 30/11/2022.
//

import SwiftUI
import StellarApi
import Domain

struct ArticlesGridView: View {
	@StateObject private var articleVm = FetchArticlesViewModel(repository: ArticleRepositoryDefault(api: ArticlesService()))

	private let twoColumns = [
		GridItem(.flexible(), spacing: 0),
		GridItem(.flexible(), spacing: 0)
	]

	@State private var showFavoritesSheet: Bool = false

	var body: some View {
		ScrollView {
			LazyVGrid(columns:  twoColumns, spacing: 0) {
				ForEach(articleVm.articles.reversed()) { article in
					NavigationLink(destination: ArticleDetailView(article: article)) {
						ArticleImageListCell(article: article)
							.frame(width: deviceSizeDivisedByTwo, height: deviceSizeDivisedByTwo)
					}
				}
			}
		}
		.navigationTitle("navigationTitle_homepage")
		.navigationBarTitleDisplayMode(.inline)
//		.onAppear {
//			articleVm.getArticles()
//		}

		.toolbar {
			ToolbarItemGroup(placement: .navigationBarTrailing) {
				DisplayFavoritesSheetView(showFavoritesSheet: $showFavoritesSheet)
			}
		}
	}
}


struct ArticlesGridView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ArticlesGridView()
				.environmentObject(FetchArticlesViewModel(repository: ArticleRepositoryDefault(api: ArticlesService())))
		}
	}
}
