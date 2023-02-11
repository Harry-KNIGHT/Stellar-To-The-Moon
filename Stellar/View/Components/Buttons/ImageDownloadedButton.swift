//
//  ImageDownloadedButton.swift
//  Stellar
//
//  Created by Elliot Knight on 02/12/2022.
//

import SwiftUI

struct ImageDownloadedButton: View {
	@Binding var animate: Bool
    var body: some View {
		Button(action: {

		}, label: {
			Image(systemName: "checkmark")
				.font(.title2)
				.foregroundColor(.white)
		})
		.downloadDoneButtonStyle(animate: animate)
		.task {
			animate = true
			print(animate)
		}
    }
}

struct ImageDownloadedButton_Previews: PreviewProvider {
    static var previews: some View {
		ImageDownloadedButton(animate: .constant(false))
    }
}
