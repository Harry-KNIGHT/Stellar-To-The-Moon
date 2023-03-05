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
	@Binding var isImageDownloading: Bool
	@Binding var isImageDownloaded: Bool

    var body: some View {
		VStack(alignment: .leading) {
			if article.mediaType == .image {
				HeadbandsDetailActions(
					article: article,
					isImageDowloaded: $isImageDownloaded,
					isDownloadingImage: $isImageDownloading
				)
				.padding(.vertical, 10)
			}
			VStack(alignment: .leading, spacing: 10) {
				Text(article.explanation)
					.fontWeight(.medium)
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
			article: .articleSample,
			isImageDownloading: .constant(false),
			isImageDownloaded: .constant(false)
		)
		.environmentObject(ArticleDetailViewModel())
		.environmentObject(FavoriteViewModel())
    }
}
