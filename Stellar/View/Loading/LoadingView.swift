//
//  LoadingView.swift
//  Stellar
//
//  Created by Elliot Knight on 27/07/2022.
//

import SwiftUI

struct LoadingView: View {
	@State private var showLoadingIndicator = true
	@EnvironmentObject var articleVm: ArticleViewModel
    var body: some View {
		ZStack {
			VStack {
				Text("Stellar is loading data")
					.font(.title2.bold())
				ProgressView()
					.frame(width: 50, height: 50.0)
			}
			.padding()
			.background(.thinMaterial)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.foregroundColor(.primary)
			.shadow(radius: 10)
			.accessibilityLabel("Stellar is loading data, please wait.")
		}
		.onAppear {
			articleVm.getArticles()
		}
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
			.environmentObject(ArticleViewModel())
    }
}
