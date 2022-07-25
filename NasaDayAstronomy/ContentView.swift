//
//  ContentView.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject var astronomy: AstronomiApi
    var body: some View {
        VStack {
			if astronomy.nasaReponses.isEmpty {
				Text("Ya zebi")
			}else {
				ForEach(astronomy.nasaReponses, id: \.self) { response in
					Text(response.title)
					Text(response.copyright)
					Text(response.date)
				}
			}
		}.task {
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
