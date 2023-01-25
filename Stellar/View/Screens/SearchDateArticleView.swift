//
//  SearchDateArticleView.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct SearchDateArticleView: View {
	@State private var date: Date = Date.now
    var body: some View {
		VStack {
			DatePickerView(date: $date)

			Button(action: {}, label: {
				Text("Search")
					.font(.title2)
					.frame(maxWidth: .infinity)
			})
			.buttonStyle(.borderedProminent)

		}
			.navigationTitle("Enter your birthday")
    }
}

struct SearchDateArticleView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			SearchDateArticleView()
		}
    }
}
