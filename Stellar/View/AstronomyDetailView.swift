//
//  AstronomyDetailView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI

struct AstronomyDetailView: View {
	let astronomyObject: NasaAstronomyResponse
    var body: some View {
			ScrollView(.vertical, showsIndicators: false) {
				if astronomyObject.url.isEmpty {
					ProgressView()
				}else {
						if astronomyObject.mediaType == "image" {
							AstronomyImageView(astronomy: astronomyObject)
						} else {
							VideoView(videoID: astronomyObject.url)
								.frame(minHeight: 450, maxHeight: 800)
						}
					if  astronomyObject.copyright != nil {
						HStack(spacing: 3) {
							Text("Copyright: ")
							Text(astronomyObject.copyright ?? "")
							Spacer()
						}
						.foregroundStyle(.secondary)
						.padding(.leading)
					}
						VStack(alignment: .leading, spacing: 10) {
							Text("Explanation:")
								.font(.headline)
							Text(astronomyObject.explanation)
						}
							.padding()
							.background(.thinMaterial)
							.clipShape(RoundedRectangle(cornerRadius: 10))
				}
			}
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarTitle(astronomyObject.title)
    }
}

struct AstronomyDetailView_Previews: PreviewProvider {
    static var previews: some View {
		AstronomyDetailView( astronomyObject: NasaAstronomyResponse(copyright: "Mickaël MAS", date: "2022-06-07", explanation: "Do dragons fight on the altar of the sky?  Although it might appear that way, these dragons are illusions made of thin gas and dust. The emission nebula NGC 6188, home to the glowing clouds, is found about 4,000 light years away near the edge of a large molecular cloud unseen at visible wavelengths, in the southern constellation Ara (the Altar). Massive, young stars of the embedded Ara OB1 association were formed in that region only a few million years ago, sculpting the dark shapes and powering the nebular glow with stellar winds and intense ultraviolet radiation. The recent star formation itself was likely triggered by winds and supernova explosions, from previous generations of massive stars, that swept up and compressed the molecular gas. Joining NGC 6188 on this cosmic canvas, visible toward the lower right, is rare emission nebula NGC 6164, also created by one of the region's massive O-type stars. Similar in appearance to many planetary nebulae, NGC 6164's striking, symmetric gaseous shroud and faint halo surround its bright central star near the bottom edge. This impressively wide field of view spans over 2 degrees (four full Moons), corresponding to over 150 light years at the estimated distance of NGC 6188.", hdurl: "https://apod.nasa.gov/apod/image/2206/Ngc6188_Robertson_2000.jpg", mediaType: "image", serviceVersion: "v1", title: "NGC 6188: Dragons of Ara", url: "https://apod.nasa.gov/apod/image/2206/Ngc6188_Robertson_960.jpg"))
			.environmentObject(AstronomiApi())
    }
}
