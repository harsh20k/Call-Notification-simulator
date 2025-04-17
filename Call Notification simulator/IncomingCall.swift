//
//  IncomingCall.swift
//  Call Notification simulator
//
//  Created by harsh  on 17/04/25.
//

import SwiftUI

struct IncomingCallView: View {
	var onDismiss: () -> Void
	
	@State private var dragOffset: CGFloat = 0
	@GestureState private var isDragging = false
	@State private var clockWiggle = false
	
	let maxDrag: CGFloat = 220
	let buttonWidth: CGFloat = 60
	
	var body: some View {
		ZStack {
				// Background blur
			VisualEffectView(material: .ultraDark)
				.edgesIgnoringSafeArea(.all)
			
			VStack(spacing: 40) {
					// Clock emoji animation
				Text("⏰")
					.font(.system(size: 60))
					.offset(x: clockWiggle ? -8 : 8)
					.animation(
						Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true),
						value: clockWiggle
					)
					.onAppear { clockWiggle = true }
				
					// Timer title
				Text("Timer Ended")
					.font(.system(size: 32, weight: .bold))
					.foregroundColor(.white)
				
					// Slider UI
				ZStack(alignment: .leading) {
						// Background capsule with shimmer text
					Capsule()
						.fill(Color.white.opacity(0.15))
						.frame(width: maxDrag + buttonWidth, height: 60)
						.overlay(
							ShimmerText(text: "Slide to dismiss")
								.padding(.horizontal)
						)
					
						// Draggable green capsule
					Capsule()
						.fill(Color.green)
						.frame(width: buttonWidth, height: 60)
						.overlay(
							Image(systemName: "phone.fill")
								.foregroundColor(.white)
								.font(.title2)
						)
						.offset(x: dragOffset)
						.gesture(
							DragGesture()
								.updating($isDragging) { _, state, _ in state = true }
								.onChanged { value in
									if value.translation.width > 0 {
										dragOffset = min(value.translation.width, maxDrag)
									}
								}
								.onEnded { value in
									if dragOffset > maxDrag * 0.85 {
										onDismiss()
									} else {
										withAnimation(.spring()) {
											dragOffset = 0
										}
									}
								}
						)
				}
				.padding(.horizontal)
			}
		}
	}
}
struct VisualEffectView: NSViewRepresentable {
	var material: NSVisualEffectView.Material
	
	func makeNSView(context: Context) -> NSVisualEffectView {
		let view = NSVisualEffectView()
		view.material = material
		view.blendingMode = .behindWindow
		view.state = .active
		return view
	}
	
	func updateNSView(_ nsView: NSVisualEffectView, context: Context) {}
}


struct ShimmerText: View {
	var text: String
	@State private var moveGradient = false
	
	var body: some View {
		Text(text)
			.foregroundColor(.white.opacity(0.5))
			.overlay(
				LinearGradient(
					gradient: Gradient(colors: [.clear, .white.opacity(0.9), .clear]),
					startPoint: .leading,
					endPoint: .trailing
				)
				.frame(width: 120)
				.offset(x: moveGradient ? 200 : -200)
				.mask(
					Text(text)
						.font(.body)
						.bold()
				)
			)
			.onAppear {
				withAnimation(
					Animation.linear(duration: 1.5)
						.repeatForever(autoreverses: false)
				) {
					moveGradient = true
				}
			}
	}
}
