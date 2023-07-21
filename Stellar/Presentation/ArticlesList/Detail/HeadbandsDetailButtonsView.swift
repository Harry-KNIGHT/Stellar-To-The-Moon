//
//  HeadbandsDetailButtonsView.swift
//  Stellar
//
//  Created by Elliot Knight on 22/02/2023.
//
import Api
import SwiftUI

// MARK: - View

struct HeadbandsDetailButtonsView: View {

	// MARK: Properties
	@ObservedObject private var downloadImageVm = DownloadImageViewModel()

	let article: Article

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
		}
	}
}

// MARK: - Preview

struct HeadbandsDetailButtonsView_Previews: PreviewProvider {
	static var previews: some View {
		HeadbandsDetailButtonsView(
			article: .imageArticleSample,
			isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false)
		)
		.environmentObject(DownloadImageViewModel())
		.environmentObject(FavoriteViewModel())
		HeadbandsDetailButtonsView(
			article: .imageArticleSample,
			isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false)
		)
		.environmentObject(DownloadImageViewModel())
		.environmentObject(FavoriteViewModel())
	}
}
