//
//  AstronomyList.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI

struct AstronomyList: View {
	@EnvironmentObject public var astronomiesApi: AllAstronomiesApi

    var body: some View {
		NavigationView {
			VStack {
			if astronomiesApi.allAstronomies.isEmpty {
				Text("Stellar is loading data...")
					.font(.title3.bold())
					.foregroundStyle(.primary)
				ProgressView()
			}else {

					List {
						ForEach(astronomiesApi.allAstronomies.reversed(), id: \.date) { astronomy in
							NavigationLink(destination: AstronomyDetailView(astronomyObject: astronomy)) {
								VStack(alignment: .leading, spacing: 3) {
									Text(astronomy.title)
										.font(.headline)
									Text(astronomy.date)
										.font(.callout)
										.foregroundStyle(.secondary)
									Text(astronomy.explanation)
										.font(.body)
										.foregroundColor(.secondary)
										.lineLimit(2)
								}
							}
						}
					}
				}
			}
			.toolbar {
				ToolbarItem(placement: .principal) {
					Text("🪐")
						.font(.title3)
				}
			}
		}
		.task {
			await astronomiesApi.fetchAstronomiesObject()
			  }
    }

}

struct AstronomyList_Previews: PreviewProvider {
    static var previews: some View {
        AstronomyList()
			.environmentObject(AllAstronomiesApi())

    }
}
