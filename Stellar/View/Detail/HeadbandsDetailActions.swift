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

	@Binding var showShareImage: Bool

	@StateObject var downloadImageVm = DownloadImageViewModel()
	@State var sharedImage: UIImage? = nil

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

			Button(action: {
				downloadImageThenShowSheet(url: article.hdurl, showSharedImage: &showShareImage)
			}, label: {
				Image(systemName: "square.and.arrow.up")
			})

			.navigationButtonLabelStyle(.title)
			.sheet(isPresented: $showShareImage) {
				// Provide the items you want to share as an array, e.g., [yourImage]
				if let image = sharedImage {
					ActivityViewController(activityItems: ["\(article.title)", image])
				} else {
					Text("Error: Image not available for sharing.")
				}
			}
			Spacer()
		}
	}

	func downloadImageThenShowSheet(url: String?, showSharedImage: inout Bool) {
		Task {
			guard let imageHdUrl = article.hdurl else { return }
			let image = try await downloadImageVm.getImage(from: imageHdUrl)
			sharedImage = image
			if self.sharedImage != nil {
				showShareImage = true
			}
		}
	}
}

struct HeadbandsDetailActions_Previews: PreviewProvider {
	static var previews: some View {
		HeadbandsDetailActions(
			article: .articleSample,
			isImageDowloaded: .constant(false),
			isDownloadingImage: .constant(false),
			showShareImage: .constant(false)
		)
		.environmentObject(DownloadImageViewModel())
		.environmentObject(FavoriteViewModel())
	}
}
