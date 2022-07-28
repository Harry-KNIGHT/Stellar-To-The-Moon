//
//  LoadingView.swift
//  Stellar
//
//  Created by Elliot Knight on 27/07/2022.
//

import SwiftUI
import ActivityIndicatorView
struct LoadingView: View {
	@State private var showLoadingIndicator = true
    var body: some View {
		ZStack {
			RadialGradient(gradient: Gradient(colors: [Color("PurpleKalash"), Color("PurpleHaze")]), center: .center, startRadius: 350, endRadius: 150).ignoresSafeArea()
			VStack {
				Text("Stellar is loading data")
					.font(.title2.bold())
				ActivityIndicatorView(isVisible: $showLoadingIndicator, type: .scalingDots())
					.frame(width: 60, height: 60.0)
			}
			.padding()
			.background(.thinMaterial)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.foregroundColor(.primary)
			.shadow(radius: 10)
		}
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
