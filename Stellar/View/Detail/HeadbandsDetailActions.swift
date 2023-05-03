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
	var isOnRandomArticleGeneration: Bool

	@Binding var isImageDowloaded: Bool
	@Binding var isDownloadingImage: Bool
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

			if isOnRandomArticleGeneration {
				GenerateRandomArticleButton()
				Spacer()
			}
		}
    }
}

struct HeadbandsDetailActions_Previews: PreviewProvider {
    static var previews: some View {
        HeadbandsDetailActions(
			article: .imageArticleSample,
			isOnRandomArticleGeneration: false, isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false)
		)
		.environmentObject(DownloadImageViewModel())
		.environmentObject(FavoriteViewModel())
		HeadbandsDetailActions(
			article: .imageArticleSample,
			isOnRandomArticleGeneration: true,
			isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false)
		)
		.environmentObject(DownloadImageViewModel())
		.environmentObject(FavoriteViewModel())
    }
}
