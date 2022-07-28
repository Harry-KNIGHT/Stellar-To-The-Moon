//
//  PeopleInSpaceAsyncImage.swift
//  Stellar
//
//  Created by Elliot Knight on 28/07/2022.
//

import SwiftUI
import ActivityIndicatorView

struct PeopleInSpaceAsyncImage: View {
	let peopleInSpace: PeopleInSpaceResponse
	@State private var isLoadingVisible = true
	var maxHeight: CGFloat = 500

	var body: some View {
		ZStack(alignment: .bottomTrailing) {
			ForEach(peopleInSpace.people, id: \.self) { p in
				AsyncImage(url: URL(string: String(p.image))) { image in
				image
					.resizable()
					.scaledToFill()
					.frame(maxHeight: maxHeight)

			} placeholder: {
				ActivityIndicatorView(isVisible: $isLoadingVisible, type: .equalizer(count: 10))
					.frame(width: 100, height: 50)
					.foregroundColor(.primary)
			}
			}
		}
	}
}

struct PeopleInSpaceAsyncImage_Previews: PreviewProvider {
	static var previews: some View {
		PeopleInSpaceAsyncImage(peopleInSpace: PeopleInSpaceResponse(number: 10,
																	 issExpedition: 67,
																	 expeditionPatch: "https://upload.wikimedia.org/wikipedia/commons/d/d3/ISS_Expedition_67_Patch.png",
																	 expeditionURL: "https://en.wikipedia.org/wiki/Expedition_67",
																	 expeditionImage: "https://upload.wikimedia.org/wikipedia/commons/5/5e/Expedition_67_crew_portrait.jpg",
																	 people: [
																		Person(id: 1, name: "Oleg Artemyev",
																				country: "Russia", flagCode: "ru",
																				 agency: "Roscosmos",
																			   position: "Commander",
																			 spacecraft: .soyuzMS21,
																			   launched: 1647615318,
																					iss: true,
																			daysInSpace: 361,
																					url: "https://en.wikipedia.org/wiki/Oleg_Artemyev",
																				  image: "https://upload.wikimedia.org/wikipedia/commons/5/5a/Oleg_Artemyev_in_2021.jpg")
																		]))
	}
}
