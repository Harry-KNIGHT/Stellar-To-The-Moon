//
//  ScreenBound.swift
//  Stellar
//
//  Created by Elliot Knight on 29/03/2023.
//

import SwiftUI

public extension View {
	func getRect() -> CGRect {
		return UIScreen.main.bounds
	}

	var deviceWidth: CGFloat {
		UIScreen.main.bounds.width
	}

	var deviceSizeDivisedByTwo: CGFloat {
		deviceWidth / 2
	}
}
