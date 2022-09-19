//
//  IssLiveView.swift
//  Stellar
//
//  Created by Elliot Knight on 05/08/2022.
//

import SwiftUI

struct IssLiveView: View {
	var body: some View {
		VStack {
			VideoView(videoID: "https://www.youtube.com/embed/86YLFOog4GM")
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.ignoresSafeArea(.container, edges: .top)
		}
	}
}

struct IssLiveView_Previews: PreviewProvider {
	static var previews: some View {
		IssLiveView()
	}
}
