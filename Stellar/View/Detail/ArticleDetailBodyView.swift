//
//  ArticleDetailBodyView.swift
//  Stellar
//
//  Created by Elliot Knight on 05/03/2023.
//

import SwiftUI
import StellarMoonKit

struct ArticleDetailBodyView: View {
	let article: Article
	let isOnRandomArticleGeneration: Bool
	@Binding var isImageDownloading: Bool
	@Binding var isImageDownloaded: Bool


    var body: some View {
		VStack(alignment: .leading) {
			
			HeadbandsDetailActions(
				article: article,
				isOnRandomArticleGeneration: isOnRandomArticleGeneration,
				isImageDowloaded: $isImageDownloaded,
				isDownloadingImage: $isImageDownloading
			)
			.padding(.vertical, 10)
			
			VStack(alignment: .leading, spacing: 10) {
				Text(article.explanation)
					.font(.title3)
					.multilineTextAlignment(.leading)
					.textSelection(.enabled)
					.accessibilityLabel(article.explanation)

				if let copyright = article.copyright {
					Text("© \(copyright)")
				}
			}
		}
    }
}

struct ArticleDetailBodyView_Previews: PreviewProvider {
    static var previews: some View {
		ArticleDetailBodyView(
			article: .imageArticleSample,
			isOnRandomArticleGeneration: false,
			isImageDownloading: .constant(false),
			isImageDownloaded: .constant(false)
		)
		.environmentObject(DownloadImageViewModel())
		.environmentObject(FavoriteViewModel())
    }
}
