//
//  PersonSpaceDetailView.swift.swift
//  Stellar
//
//  Created by Elliot Knight on 28/07/2022.
//

import SwiftUI
import ActivityIndicatorView
import StellarMoonKit

struct PersonSpaceDetailView: View {
	let personInSpace: Person
	var maxHeight: CGFloat = 200
	@State private var isLoadingVisible = true
	@State private var isShwoingSheet: Bool = false
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			PersonInSpaceAsyncImage(personInSpace: personInSpace)
			VStack(alignment: .leading, spacing: 10) {

				HStack {
					Text("Agency: \(personInSpace.agency)")
					Spacer()
					if personInSpace.iss {
						Text("ISS")
							.foregroundColor(.primary)
					}
				}
				Text("Country: \(personInSpace.country), \(personInSpace.flagCode)")

				Text("Spacecraft: \(personInSpace.spacecraft.rawValue)")
				Text("Launched at: \(lauchingDate)")
				Text(personInSpace.daysInSpace > 0 ? "Days in space: \(personInSpace.daysInSpace)" : "Day in space: \(personInSpace.daysInSpace)")
				Text("Role: \(personInSpace.position)")
			}
			.padding()
			.background(.thinMaterial)
			.clipShape(RoundedRectangle(cornerRadius: 10))

			Button(action: {
				isShwoingSheet.toggle()

			}, label: {
				Label("Show in Wikipedia", systemImage: "network")
					.font(.title3)
					.padding(5)
			})
			.buttonStyle(.bordered)
			.tint(.blue)
			.buttonBorderShape(.roundedRectangle)
			.padding(.bottom)
			.sheet(isPresented: $isShwoingSheet) {
				NavigationView {
					if let wikiURL = URL(string: personInSpace.url) {
						WebView(url: wikiURL)
							.navigationBarTitleDisplayMode(.inline)
							.navigationTitle(personInSpace.name)
							.toolbar {
								ToolbarItem(placement: .navigationBarTrailing) {
									Button("Dismiss") {
										self.isShwoingSheet.toggle()
									}
								}
							}
					}
				}
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationTitle(personInSpace.name)
	}

	var lauchingDate: String {
		let launchedAt = personInSpace.launched
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		let launchDate = Date(timeIntervalSince1970: Double(launchedAt))

		let dateString = formatter.string(from: launchDate)

		return dateString
	}
}

struct PersonSpaceDetailView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			PersonSpaceDetailView(personInSpace: .peopleSample)
		}
	}
}
