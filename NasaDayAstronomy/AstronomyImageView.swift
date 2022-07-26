//
//  AstronomyImageView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI

struct AstronomyImageView: View {
	let astronomy: NasaAstronomyResponse
	@Environment(\.colorScheme) var colorScheme
	var body: some View {
		ZStack(alignment: .bottomTrailing) {
			AsyncImage(url: URL(string:astronomy.hdurl ?? "")) { image in
				image
					.resizable()
					.frame(maxHeight: 500)
					.clipShape(RoundedRectangle(cornerRadius: 20))
					.padding(5)
			} placeholder: {
				ProgressView()
			}
			Text(astronomy.copyright)
				.font(.caption)
				.foregroundColor(colorScheme == .dark ? .white : .primary)
				.padding([.all], 5)
			   .background(colorScheme == .dark ? .black : .white)
		}
	}
}

struct AstronomyImageView_Previews: PreviewProvider {
    static var previews: some View {
		AstronomyImageView(astronomy: NasaAstronomyResponse(copyright: "Mohamad Soltanolkotabi", date: "2022-07-25", explanation:  "Can you find the Moon? This usually simple task can be quite difficult.  Even though the Moon is above your horizon half of the time, its phase can be anything from crescent to full. The featured image was taken in late May from Sant Martí d'Empúries, Spain, over the Mediterranean Sea in the early morning. One reason you can't find this moon is because it is very near to its new phase, when very little of the half illuminated by the Sun is visible to the Earth. Another reason is because this moon is near the horizon and so seen through a long path of Earth's atmosphere -- a path which dims the already faint crescent. Any crescent moon is only visible near the direction the Sun, and so only locatable near sunrise of sunset. The Moon runs through all of its phases in a month (moon-th), and this month the thinnest sliver of a crescent -- a new moon -- will occur in three days.", hdurl: "https://apod.nasa.gov/apod/image/2207/FindTheMoon_soltanolkotabi_1500.jpg", mediaType: "image", serviceVersion: "v1", title: "Find the New Moon", url: "https://apod.nasa.gov/apod/image/2207/FindTheMoon_soltanolkotabi_1080.jpg"))
    }
}
