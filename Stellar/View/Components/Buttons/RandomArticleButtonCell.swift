//
//  RandomArticleButtonCell.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct RandomArticleButtonCell: View {
	@Binding var showBirthdayPicker: Bool
	var isShowingRandArticleGeneration: Bool

    var body: some View {
        Button(action: {
			showBirthdayPicker.toggle()
		}, label: {
			Image(systemName: "shuffle.circle.fill")
				.customButtonStyle()
		})
		.sheet(isPresented: $showBirthdayPicker) {
			SearchDateArticleView()
		}
    }
}

struct RandomArticleButtonCell_Previews: PreviewProvider {
    static var previews: some View {
		ShowRandomArticleView(
			showBirthdayPicker: .constant(false),
			isShowingRandArticleGeneration: true
		)
    }
}
