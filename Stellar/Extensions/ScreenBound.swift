//
//  ScreenBound.swift
//  Stellar
//
//  Created by Elliot Knight on 29/03/2023.
//

import SwiftUI

// Extending view to get screen bounds
extension View {
	func getRect() -> CGRect {
		return UIScreen.main.bounds
	}
}

