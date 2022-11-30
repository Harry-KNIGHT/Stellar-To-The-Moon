//
//  ArticlesGridView.swift
//  
//
//  Created by Elliot Knight on 30/11/2022.
//

import SwiftUI

struct ArticlesGridView: View {
	@EnvironmentObject public var articleApi: AstronomiesArticleViewModel

	private let columnsiPhone = [
		GridItem(.flexible(), spacing: 0),
		GridItem(.flexible(), spacing: 0)
	]
	private let columnsiPad = [
		GridItem(.flexible(), spacing: 0),
	]
	private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
	@Binding var showSheet: Bool
	var body: some View {
		ScrollView {
			LazyVGrid(columns: idiom == .phone ? columnsiPhone : columnsiPad, alignment: .center, spacing: 0) {
				ForEach(articleApi.allAstronomies.reversed(), id: \.date) { article in
					NavigationLink(destination: AstronomyDetailView(article: article)) {
						if article.mediaType == .image {
							AstronomyImageListCell(article: article)
						} else {
							VideoPlaceHolderCell(article: article)
						}
					}
				}
			}
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				if !articleApi.allAstronomies.isEmpty {
					ShowFavSheetButtonCell(showSheet: $showSheet)
				}
			}
		}
		.refreshable {
			do {
				try await articleApi.getAstronomiesArticles(to: Date.now)
			} catch {
				print("Error while refresh: \(error.localizedDescription)")
			}
		}
	}
}


struct ArticlesGridView_Previews: PreviewProvider {
    static var previews: some View {
		ArticlesGridView(showSheet: .constant(false))
    }
}
