//
//  PinchZoom.swift
//  Stellar
//
//  Created by Elliot Knight on 29/03/2023.
//

import SwiftUI
import UIKit


// Add Pich to Zoom custom modifier
extension View {
	func addPinchZoom() -> some View {
		return PinchZoomContext {
			self
		}
	}
}

// Helper Structs..
struct PinchZoomContext<Content: View>: View {
	var content: Content

	init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content()
	}

	// Offset and Scale Data
	@State var offset: CGPoint = .zero
	@State var scale: CGFloat = 0

	@State var scalePosition: CGPoint = .zero

	// Where creating a SceneStorage that will give whether the zooming is happening or not
	@SceneStorage("isZooming") var isZooming: Bool = false

	var body: some View {

		content

		// Applying offset before scaling
			.offset(x: offset.x, y: offset.y)

		// Using UIKit Gestures for simulatenously recognize both Pinch and Pan Gesture
			.overlay(
				GeometryReader { proxy in
					let size = proxy.size
					ZoomGesture(
						size: size,
						scale: $scale,
						offset: $offset,
						scalePosition: $scalePosition
					)
				}
			)

		// Scaling content
			.scaleEffect(1 + (scale < 0 ? 0 : scale), anchor: .init(x: scalePosition.x, y: scalePosition.y))

		// Making it top when zooming started
			.zIndex(scale != 0 ? 1000 : 0)
			.onChange(of: scale) { newValue in
				isZooming = (scale != 0 && offset != .zero)
				if scale == -1 {
					// Giving some time to finish animation
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
						scale = 0
					}
				}
			}
	}
}

struct ZoomGesture: UIViewRepresentable {

	// Getting size for calculating scale
	var size: CGSize
	@Binding var scale: CGFloat
	@Binding var offset: CGPoint
	@Binding var scalePosition: CGPoint

	// Connecting Coordinator
	func makeCoordinator() -> Coordinator {
		return Coordinator(parent: self)
	}

	func makeUIView(context: Context) -> UIView {

		let view = UIView()
		view.backgroundColor = .clear

		// Adding Gestures
		let PinchGesture = UIPinchGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePinch(sender:)))
		view.addGestureRecognizer(PinchGesture)

		// Adding pan Gestures
		let PanGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handlePan(sender:)))
		view.addGestureRecognizer(PanGesture)

		PanGesture.delegate = context.coordinator
		return view
	}

	func updateUIView(_ uiView: UIView, context: Context) { }

	// Creating  Handlers for gestures
	class Coordinator: NSObject, UIGestureRecognizerDelegate {
		var parent: ZoomGesture

		init(parent: ZoomGesture) {
			self.parent = parent
		}

		// Making pan to recognize simulatenously
		func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
			return true
		}

		@objc
		func handlePan(sender: UIPanGestureRecognizer) {

			// Setting max touch
			sender.maximumNumberOfTouches = 2

			// Min scale is 1
			if (sender.state == .began || sender.state == .changed) && parent.scale > 0 {
				if let view = sender.view {
					// Getting translation
					let translation = sender.translation(in: view)

					parent.offset = translation
				}
			} else {
				withAnimation(.easeOut(duration: 0.35)) {
					parent.offset = .zero
					parent.scalePosition = .zero

				}
			}
		}

		@objc
		func handlePinch(sender: UIPinchGestureRecognizer) {
			// Calculating scale
			if sender.state == .began || sender.state == .changed {
				// Setting scale
				parent.scale = (sender.scale - 1)

				// Getting the position where user pinched and applying scale at that position
				let scalePoint = CGPoint(
					x: sender.location(in: sender.view).x / sender.view!.frame.size.width,
					y:  sender.location(in: sender.view).y / sender.view!.frame.size.height
				)
				// The result will be ((0...1), (0...1))

				// Updating scale point for only once
				parent.scalePosition = (parent.scalePosition == .zero ? scalePoint : parent.scalePosition)
			} else {
				// Setting scale to 0
				withAnimation(.easeOut(duration: 0.35)) {
					parent.scale = -1
					parent.scalePosition = .zero
				}
			}
		}
	}
}
