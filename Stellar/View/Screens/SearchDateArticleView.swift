//
//  SearchDateArticleView.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct SearchDateArticleView: View {
	@EnvironmentObject private var searchDateVM: SearchDateArticleViewModel
	@ObservedObject private var articlesVM = ArticleViewModel()

	var body: some View {
		NavigationView {
			if let search = searchDateVM.article  {
				ArticleDetailView(article: search, isShowingRandArticleGenration: true)
			}
		}
		.onAppear {
			searchDateVM.generateOneArticle()
		}
	}
}

struct SearchDateArticleView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			SearchDateArticleView()
				.environmentObject(SearchDateArticleViewModel())
				.environmentObject(ArticleViewModel())
		}
	}
}
