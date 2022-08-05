//
//  CircularProgressBar.swift
//  Stellar
//
//  Created by Elliot Knight on 05/08/2022.
//

import SwiftUI

struct CircularProgressBar: View {
	var circleProgress: CGFloat = 0.0
	var width: CGFloat = 25
	var height: CGFloat = 25
	var lineWidth: CGFloat = 7
	var lineColor: Color = Color.white
	var body: some View {
		VStack {
			ZStack {
				Circle()
					.stroke(Color.gray, lineWidth: lineWidth)
					.frame(width: width, height: height)
				Circle()
					.trim(from: 0.0, to: circleProgress)
					.stroke(lineColor, lineWidth: lineWidth)
					.frame(width: width, height: height)
					.rotationEffect(Angle(degrees: -90))

//				Text("\(Int(self.circleProgress*100))%")
//					.font(.callout)
//					.foregroundColor(.white)
			}
		}
	}
}

struct CircularProgressBar_Previews: PreviewProvider {
	static var previews: some View {
		CircularProgressBar()
	}
}
