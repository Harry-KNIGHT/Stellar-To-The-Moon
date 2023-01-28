//
//  SearchDateArticleView.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct SearchDateArticleView: View {
	@EnvironmentObject var searchDateVM: SearchDateArticleViewModel
	@ObservedObject var articlesVM = AstronomiesArticleViewModel()
	@State private var date: Date = Date.now
	var body: some View {
		NavigationView {
			VStack {
				HStack {
					DatePickerView(date: $date)
				}
				.padding(.horizontal)
				.padding(.top, 5)
				
				Spacer()
				if let search = searchDateVM.article  {
					AstronomyDetailView(article: search)
				} else {
					if let lastArticle = articlesVM.allAstronomies.last {
						AstronomyDetailView(article: lastArticle)
					} else {
						AstronomyDetailView(article: .astronomySample)
					}
				}
				Spacer()
			}
			.onChange(of: date, perform: { newDateSearch in
				searchDateVM.searchOneArticle(date: newDateSearch)
			})
		}
	}
}

struct SearchDateArticleView_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			SearchDateArticleView()
				.environmentObject(SearchDateArticleViewModel())
				.environmentObject(AstronomiesArticleViewModel())
		}
	}
}
