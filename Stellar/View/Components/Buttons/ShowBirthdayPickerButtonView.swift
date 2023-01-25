//
//  ShowBirthdayPickerView.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct ShowBirthdayPickerButtonView: View {
	@Binding var showBirthdayPicker: Bool

    var body: some View {
        Button(action: {
			showBirthdayPicker.toggle()
		}, label: {
			Image(systemName: "birthday.cake.fill")
				.sheetButtonsStyle()
		})
		.sheet(isPresented: $showBirthdayPicker) {
			SearchDateArticleView()
		}
    }
}

struct ShowBirthdayPickerButtonView_Previews: PreviewProvider {
    static var previews: some View {
		ShowBirthdayPickerButtonView(showBirthdayPicker: .constant(false))
    }
}
