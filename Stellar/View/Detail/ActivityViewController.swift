//
//  ActivityViewController.swift
//  Stellar
//
//  Created by Elliot Knight on 13/04/2023.
//

import UIKit
import SwiftUI

struct ActivityViewController: UIViewControllerRepresentable {
	let activityItems: [Any]
	let applicationActivities: [UIActivity]? = nil

	func makeUIViewController(context: Context) -> UIActivityViewController {
		let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
		return controller
	}

	func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
		// No updates needed
	}
}
