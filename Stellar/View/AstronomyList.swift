//
//  AstronomyList.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 26/07/2022.
//

import SwiftUI
import ActivityIndicatorView

struct AstronomyList: View {
	@EnvironmentObject public var astronomiesApi: AllAstronomiesApi
	@State private var showSheet = false
	@State private var showLoadingIndicator = true
	var linewidth: CGFloat = 5
	var body: some View {
		NavigationView {
			VStack {
				if astronomiesApi.allAstronomies.isEmpty {
					Text("Stellar is loading data...")
						.font(.title3.bold())
						.foregroundStyle(.primary)
					ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .growingArc(lineWidth: linewidth))
						.foregroundColor(.red)
						.frame(width: 50.0, height: 50.0)
				}else {
					List {
						ForEach(astronomiesApi.allAstronomies.reversed(), id: \.date) { astronomy in
							NavigationLink(destination: AstronomyDetailView(astronomyObject: astronomy)) {
								ListRowCell(title: astronomy.title, date: astronomy.date, explanation: astronomy.explanation)
							}
						}
					}
				}
			}
			.navigationTitle("Stellar")
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: {
						showSheet.toggle()

					}, label: {
						Label("Add article to favorite", systemImage: "star.fill")
							.font(.title3)
							.foregroundColor(.primary)
					}).sheet(isPresented: $showSheet) {
						FavoritesList()
					}
				}
			}
		}.refreshable {
			Task {
				astronomiesApi.allAstronomies
			}
		}
		.task {
			await astronomiesApi.fetchAstronomiesObject(to: Date.now)
		}
	}
}

struct AstronomyList_Previews: PreviewProvider {
	static var previews: some View {
		AstronomyList()
			.environmentObject(AllAstronomiesApi())
	}
}

struct ListRowCell: View {
	var title: String
	var date: String
	var explanation: String
	var body: some View {
		VStack(alignment: .leading, spacing: 3) {
			Text(title)
				.font(.headline)
			Text(date)
				.font(.callout)
				.foregroundStyle(.secondary)
			Text(explanation)
				.font(.body)
				.foregroundColor(.secondary)
				.lineLimit(2)
		}
	}
}
