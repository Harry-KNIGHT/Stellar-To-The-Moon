//
//  ContentView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI

struct ContentView: View {
	@StateObject var astronomy: AstronomiApi = AstronomiApi()
	var body: some View {
		NavigationStack {
			ScrollView(.vertical, showsIndicators: false) {
				if astronomy.nasaReponses.isEmpty {
					ProgressView()
				}else {
					ForEach(astronomy.nasaReponses, id: \.self) { response in

						HStack {
							Text(response.title)
								.font(.title3.bold())

							Spacer()
							Text(response.date)
								.foregroundStyle(.secondary)
						}.padding(.horizontal)

						AstronomyImageView(astronomy: response)
						VStack(alignment: .leading, spacing: 10) {
							Text("Explanation:")
								.font(.headline)
							Text(response.explanation)
						}
							.padding()
							.background(.thinMaterial)
							   .clipShape(RoundedRectangle(cornerRadius: 10))
							   .padding(.horizontal, 5)

					}
				}
			}
			.navigationTitle("Astronomy Picture of the Day")
			.navigationBarTitleDisplayMode(.inline)
		}
		.task {
			do {
				try await astronomy.nasaApiCall()
			}catch {
				print("Error, \(error)")
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(AstronomiApi())
	}
}
