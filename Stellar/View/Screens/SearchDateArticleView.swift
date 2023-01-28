//
//  SearchDateArticleView.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct SearchDateArticleView: View {
	@EnvironmentObject var searchDateVM: SearchDateArticleViewModel
	@State private var date: Date = Date.now
	var body: some View {
		NavigationView {
			VStack {
				HStack {
					DatePickerView(date: $date)

					Button(action: {
						searchDateVM.searchOneArticle(date: date)
					}, label: {
						Text("Search")
							.frame(maxWidth: .infinity)
					})
					.buttonStyle(.borderedProminent)
				}
				.padding(.horizontal)
				.padding(.top, 5)
				
				Spacer()
				if let search = searchDateVM.article  {
					AstronomyDetailView(article: search)
				}
				Spacer()
			}
			.navigationTitle("Search by date")
		}
	}
}

struct SearchDateArticleView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			SearchDateArticleView()
				.environmentObject(SearchDateArticleViewModel())
		}
	}
}
