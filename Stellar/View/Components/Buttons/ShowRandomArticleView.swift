//
//  ShowRandomArticleView.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct ShowRandomArticleView: View {
	@Binding var showBirthdayPicker: Bool

    var body: some View {
        Button(action: {
			showBirthdayPicker.toggle()
		}, label: {
			Image(systemName: "shuffle.circle.fill")
				.navigationButtonLabelStyle()
		})
		.sheet(isPresented: $showBirthdayPicker) {
			SearchDateArticleView()
		}
    }
}

struct ShowRandomArticleView_Previews: PreviewProvider {
    static var previews: some View {
		ShowRandomArticleView(showBirthdayPicker: .constant(false))
    }
}
