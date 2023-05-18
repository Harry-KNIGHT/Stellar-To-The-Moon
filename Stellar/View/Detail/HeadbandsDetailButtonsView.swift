//
//  HeadbandsDetailButtonsView.swift
//  Stellar
//
//  Created by Elliot Knight on 22/02/2023.
//
import StellarMoonKit
import SwiftUI

// MARK: - View

struct HeadbandsDetailButtonsView: View {

	// MARK: Properties
	@ObservedObject private var downloadImageVm = DownloadImageViewModel()

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
				GenerateRandomArticleButtonCell()
				Spacer()
			}
		}
	}
}

// MARK: - Preview

struct HeadbandsDetailButtonsView_Previews: PreviewProvider {
	static var previews: some View {
		HeadbandsDetailButtonsView(
			article: .imageArticleSample,
			isOnRandomArticleGeneration: false, isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false)
		)
		.environmentObject(DownloadImageViewModel())
		.environmentObject(FavoriteViewModel())
		HeadbandsDetailButtonsView(
			article: .imageArticleSample,
			isOnRandomArticleGeneration: true,
			isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false)
		)
		.environmentObject(DownloadImageViewModel())
		.environmentObject(FavoriteViewModel())
	}
}
