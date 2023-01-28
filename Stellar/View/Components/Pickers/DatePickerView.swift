//
//  DatePickerView.swift
//  Stellar
//
//  Created by Elliot Knight on 25/01/2023.
//

import SwiftUI

struct DatePickerView: View {
	@Binding var date: Date
    var body: some View {
		DatePicker("Select date", selection: $date, displayedComponents: [.date])
			.datePickerStyle(.compact)
			.labelsHidden()
			.frame(maxWidth: .infinity)
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
		DatePickerView(date: .constant(.now))
    }
}
