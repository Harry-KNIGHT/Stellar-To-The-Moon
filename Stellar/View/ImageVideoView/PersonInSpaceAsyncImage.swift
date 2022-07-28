//
//  PeopleInSpaceAsyncImage.swift
//  Stellar
//
//  Created by Elliot Knight on 28/07/2022.
//

import SwiftUI
import ActivityIndicatorView

struct PersonInSpaceAsyncImage: View {
	let personInSpace: Person
	@State private var isLoadingVisible = true
	var maxHeight: CGFloat = 500

	var body: some View {
		ZStack(alignment: .bottomTrailing) {
			AsyncImage(url: URL(string: personInSpace.image)) { image in
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

struct PersonInSpaceAsyncImage_Previews: PreviewProvider {
	static var previews: some View {
		PersonInSpaceAsyncImage(personInSpace: Person(
			id: 1, name: "Oleg Artemyev",
			country: "Russia", flagCode: "ru",
			agency: "Roscosmos",
			position: "Commander",
			spacecraft: .soyuzMS21,
			launched: 1647615318,
			iss: true,
			daysInSpace: 361,
			url: "https://en.wikipedia.org/wiki/Oleg_Artemyev",
			image: "https://upload.wikimedia.org/wikipedia/commons/5/5a/Oleg_Artemyev_in_2021.jpg"))
	}
}
