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
	@Binding var isImageDowloaded: Bool
	@Binding var isDownloadingImage: Bool
	@StateObject var favorites = FavoriteViewModel()
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
    }
}

struct HeadbandsDetailActions_Previews: PreviewProvider {
    static var previews: some View {
        HeadbandsDetailActions(
			article: .articleSample,
			isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false)
		)
		.environmentObject(DownloadImageViewModel())
		.environmentObject(FavoriteViewModel())
    }
}
