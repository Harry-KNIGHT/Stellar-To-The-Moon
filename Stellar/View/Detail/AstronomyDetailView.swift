//
//  AstronomyDetailView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import UIKit
import ActivityIndicatorView

// method get image
// do urlDataTask 
struct AstronomyDetailView: View {
	let article: NasaAstronomyResponse
	@State private var isSheetPresented = false
	@EnvironmentObject var favoriteVM: FavoriteViewModel
	@EnvironmentObject var astronomyApi: AstronomyApi
	@State private var isImageDowloaded: Bool = false
	@State private var isDownloadingImage = false
	@State private var showLoading = true
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
				if article.mediaType == "image" {
					AstronomyImageView(astronomy: article)
				} else {
					VideoView(videoID: article.url)
						.frame(minHeight: 450, maxHeight: 800)
				}
				HStack {
					if article.mediaType == "image" {
						if !isImageDowloaded {
						Button(action: {
							do {
								self.isDownloadingImage.toggle()
								guard let urlString = article.hdurl else {
									throw ApiError.urlNotFound
								}
								Task {
									let imageSaver = ImageSaver()
									let image = try await astronomyApi.getImage(from: urlString)
									imageSaver.writeToPhotoAlbum(image: image)
									isImageDowloaded.toggle()
								}

							}catch {
								print("Error \(error.localizedDescription)")
							}

						}, label: {
							if !isDownloadingImage {
							Label("Download image", systemImage: "arrow.down.circle.fill")
									.font(.title3.bold())
							}else {
								HStack {
									ActivityIndicatorView(isVisible: $showLoading, type: .arcs(count: 3, lineWidth: CGFloat(1.5)))
										.frame(width: 20, height: 20)
									Text("Downlading image")
										.font(.title3.bold())
								}
							}

						})
						.buttonStyle(.bordered)
						.tint(Color.blue)
						.buttonBorderShape(.roundedRectangle)
						} else  {
							Text("\(Image(systemName: "checkmark.circle.fill")) Image downloaded")
								.font(.title3.bold())
								.padding(5)
								.foregroundColor(.green)
								.background(.regularMaterial)
								.cornerRadius(10)
						}
					}
				}
				VStack(alignment: .leading, spacing: 10) {
					Text("Explanation:")
						.font(.headline)
					Text(article.explanation)
				}
				.padding()
				.background(.thinMaterial)
				.clipShape(RoundedRectangle(cornerRadius: 10))

		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationBarTitle(article.title)
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {
					favoriteVM.addOrDeletFavorite(article: article)
				}, label: {
					Label("Add article to favorite", systemImage: favoriteVM.favoriteAstronomyArticles.contains(article) ? "star.fill" : "star")
						.foregroundColor(.primary)
						.font(.title3)
				})
			}
		}
	}
}

struct AstronomyDetailView_Previews: PreviewProvider {
	static var previews: some View {
		AstronomyDetailView(article: NasaAstronomyResponse(copyright: "Mickaël MAS", date: "2022-06-07", explanation: "Do dragons fight on the altar of the sky?  Although it might appear that way, these dragons are illusions made of thin gas and dust. The emission nebula NGC 6188, home to the glowing clouds, is found about 4,000 light years away near the edge of a large molecular cloud unseen at visible wavelengths, in the southern constellation Ara (the Altar). Massive, young stars of the embedded Ara OB1 association were formed in that region only a few million years ago, sculpting the dark shapes and powering the nebular glow with stellar winds and intense ultraviolet radiation. The recent star formation itself was likely triggered by winds and supernova explosions, from previous generations of massive stars, that swept up and compressed the molecular gas. Joining NGC 6188 on this cosmic canvas, visible toward the lower right, is rare emission nebula NGC 6164, also created by one of the region's massive O-type stars. Similar in appearance to many planetary nebulae, NGC 6164's striking, symmetric gaseous shroud and faint halo surround its bright central star near the bottom edge. This impressively wide field of view spans over 2 degrees (four full Moons), corresponding to over 150 light years at the estimated distance of NGC 6188.", hdurl: "https://apod.nasa.gov/apod/image/2206/Ngc6188_Robertson_2000.jpg", mediaType: "image", serviceVersion: "v1", title: "NGC 6188: Dragons of Ara", url: "https://apod.nasa.gov/apod/image/2206/Ngc6188_Robertson_960.jpg"))
			.environmentObject(AstronomyApi())
			.environmentObject(FavoriteViewModel())
			.environmentObject(AstronomyApi())
	}
}
