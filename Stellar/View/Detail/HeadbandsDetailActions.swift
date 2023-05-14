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
