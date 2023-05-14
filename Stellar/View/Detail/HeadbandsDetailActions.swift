//
//  HeadbandsDetailActions.swift
//  Stellar
//
//  Created by Elliot Knight on 22/02/2023.
//
import StellarMoonKit
import SwiftUI

struct HeadbandsDetailActions: View {
	let article: Article

	private let shareLinkImage: Image = Image("StellarIcon")

	@Binding var isImageDowloaded: Bool
	@Binding var isDownloadingImage: Bool
	var isShowingRandArticleGenration: Bool = false
	@StateObject var favorites = FavoriteViewModel()
	@StateObject var deeplinkManager = DeepLinkManager()

    var body: some View {
		HStack {
			Spacer()

				AddFavoriteButtonCell(article: article)
				Spacer()

				DownloadImageButton(
					article: article,
					isImageDowloaded: $isImageDowloaded,
					isDownloadingImage: $isDownloadingImage
				)

				Spacer()

			if #available(iOS 16.0, *), !isShowingRandArticleGenration {
					ShareLink(
						item: URL(string: "stellar://article?date=\(article.date)")!,
						message: Text("Hey ! Check this beautiful photo on Stellar To The Moon !"),
						preview: SharePreview("Stellar To The Moon", image: shareLinkImage)
					) {
						Image(systemName: "square.and.arrow.up")
					}
					Spacer()
				}
		}
		.navigationButtonLabelStyle(.title)
    }
}

struct HeadbandsDetailActions_Previews: PreviewProvider {
    static var previews: some View {
		HeadbandsDetailActions(
			article: .imageArticleSample,
			isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false),
			isShowingRandArticleGenration: false
		)
		.environmentObject(DownloadImageViewModel())
		.environmentObject(FavoriteViewModel())
    }
}
