//
//  ArticlesGridView.swift
//  Stellar
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
	@Binding var showBirthdayPicker: Bool

	var body: some View {
		ScrollView {
			LazyVGrid(columns: idiom == .phone ? columnsiPhone : columnsiPad, alignment: .center, spacing: 0) {
				ForEach(articleApi.allAstronomies.reversed(), id: \.date) { article in
					NavigationLink(destination: AstronomyDetailView(article: article)) {
						if article.mediaType == .image {
							AstronomyImageListCell(article: article, isInFavoriteListView: false)
						} else {
							VideoPlaceHolderCell(article: article)
						}
					}
				}
			}
		}
		.toolbar {
			ToolbarItemGroup(placement: .navigationBarTrailing) {
				ShowBirthdayPickerButtonView(showBirthdayPicker: $showBirthdayPicker)

				if !articleApi.allAstronomies.isEmpty.self {
					ShowFavSheetButtonCell(showSheet: $showSheet)
				}
			}
		}
		.refreshable {
				articleApi.getAstronomiesArticles(to: Date.now)
		}
	}
}


struct ArticlesGridView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ArticlesGridView(
				showSheet: .constant(false),
				showBirthdayPicker: .constant(false)
			)
			.environmentObject(AstronomiesArticleViewModel())
		}
	}
}
