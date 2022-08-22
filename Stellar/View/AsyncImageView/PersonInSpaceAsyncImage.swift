//
//  PeopleInSpaceAsyncImage.swift
//  Stellar
//
//  Created by Elliot Knight on 28/07/2022.
//

import SwiftUI
import ActivityIndicatorView
import StellarMoonKit

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
						.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

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
		PersonInSpaceAsyncImage(personInSpace: .peopleSample)
	}
}
