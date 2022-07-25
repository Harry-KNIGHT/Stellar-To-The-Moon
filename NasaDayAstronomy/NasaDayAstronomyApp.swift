//
//  NasaDayAstronomyApp.swift
//  NasaDayAstronomy
//
//  Created by Elliot Knight on 25/07/2022.
//

import SwiftUI

@main
struct NasaDayAstronomyApp: App {
	@StateObject var astronomyApi = AstronomiApi()
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(astronomyApi)
        }
    }
}
