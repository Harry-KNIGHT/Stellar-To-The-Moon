//
//  PersonSpaceDetailView.swift.swift
//  Stellar
//
//  Created by Elliot Knight on 28/07/2022.
//

import SwiftUI
import ActivityIndicatorView

struct PersonSpaceDetailView: View {
	let personInSpace: Person
	var maxHeight: CGFloat = 200
	@State private var isLoadingVisible = true
	var body: some View {
		ScrollView {
			PersonInSpaceAsyncImage(personInSpace: personInSpace)
				.navigationBarTitleDisplayMode(.inline)
				.navigationTitle("Navigaton")
		}

	}

}

struct PersonSpaceDetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			PersonSpaceDetailView(personInSpace:
									Person(
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
}
