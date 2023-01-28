//
//  DatePickerView.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct DatePickerView: View {
	@Binding var date: Date

	let firstJanuaryTwoThousandTen = Date(timeIntervalSince1970: 1262305233)
	let now = Date.now

    var body: some View {
		DatePicker(
			"Select date",
			selection: $date,
			in: firstJanuaryTwoThousandTen...now,
			displayedComponents: [.date]
		)
			.datePickerStyle(.compact)
			.labelsHidden()
			.frame(maxWidth: .infinity)
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
		DatePickerView(date: .constant(.now))
			.environmentObject(SearchDateArticleViewModel())
			.previewLayout(.sizeThatFits)
    }
}
