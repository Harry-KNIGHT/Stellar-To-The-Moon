//
//  AstronomyImageView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI
import ActivityIndicatorView
import StellarMoonKit

struct AstronomyImageView: View {
	let astronomy: AstronomyArticleModel
	@EnvironmentObject var astronomyApi: AstronomyDetailViewModel

	@Environment(\.colorScheme) private var colorScheme

	@State private var isImageDowloaded: Bool = false
	@State private var isDownloadingImage = false

	@State private var isLoadingVisible = true
	@State private var showLoading = true
	@State private var circleProgress: CGFloat = 0.0

	@State private var animate = false
	var body: some View {
			AsyncImage(url: URL(string: astronomy.url)) { image in
			ZStack(alignment: .bottomTrailing) {
				ZStack(alignment: .bottomLeading) {
				image
					.resizable()
					.scaledToFill()
					.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

					if let copryRight = astronomy.copyright {
						Text(copryRight)
							.foregroundColor(.white)
							.padding(4)
							.background(LinearGradient(colors: [.black.opacity(0), .black.opacity(0.6)], startPoint: .top, endPoint: .center))

					}
				}
					if !isImageDowloaded {
						Button(action: {
							do {
								self.isDownloadingImage.toggle()
								self.startLoading()

								guard let urlString = astronomy.hdurl else {
									throw ApiError.urlNotFound
								}
								Task {
									let imageSaver = ImageSaver()
									let image = try await astronomyApi.getImage(from: urlString)
									imageSaver.writeToPhotoAlbum(image: image)
									isImageDowloaded.toggle()
								}
							} catch {
								print("Error \(error.localizedDescription)")
							}
						}, label: {

							if !isDownloadingImage {
								Image(systemName: "arrow.down.to.line")
									.font(.title2)
									.foregroundColor(.white)
							} else {
								CircularProgressBar(circleProgress: circleProgress, width: 25, height: 25, lineWidth: 4)
							}
						})
						.buttonStyle(.borderedProminent)
						.clipShape(Circle())
						.foregroundColor(.blue)
						.overlay {
							Circle()
								.stroke(.white, lineWidth: 0.4)
						}
						.shadow(color: .blue, radius: 10)
						.padding([.bottom, .trailing])
					} else {

						Button(action: {

						}, label: {
							Image(systemName: "checkmark")
								.font(.title2)
								.foregroundColor(.white)
						})
						.buttonStyle(.borderedProminent)
						.clipShape(Circle())
						.tint(.green)
						.overlay {
							Circle()
								.stroke(.white, lineWidth: 0.4)
						}
						.shadow(color: .green, radius: 10)
						.padding([.bottom, .trailing])
						.opacity(animate ? 0 : 1)

						.animation(.easeInOut(duration: 2).delay(1), value: animate ? 0 : 1)
						.task {
							animate = true
							print(animate)
						}
					}
			}
		} placeholder: {
			ZStack {
			Rectangle()
				.frame(minHeight: 200, maxHeight: 350)
				.foregroundStyle(.regularMaterial)

			ActivityIndicatorView(isVisible: $isLoadingVisible, type: .equalizer(count: 10))
				.frame(width: 100, height: 50)
				.foregroundColor(.primary)
			}
		}
	}
	func startLoading() {
		_ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
			withAnimation {
				self.circleProgress += 0.01
				if self.circleProgress >= 0.95 {
					timer.invalidate()
				}
			}
		}
	}
}

struct AstronomyImageView_Previews: PreviewProvider {
	static var previews: some View {
		AstronomyImageView(astronomy: .astronomySample)
			.environmentObject(AstronomyDetailViewModel())
	}
}
