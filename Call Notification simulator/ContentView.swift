//
//  ContentView.swift
//  Call Notification simulator
//
//  Created by harsh  on 17/04/25.
//

import SwiftUI

struct ContentView: View {
	@StateObject private var timerModel = TimerModel()
	@State private var inputMinutes = "1"
	
	var body: some View {
		ZStack {
			VStack(spacing: 20) {
				TextField("Minutes", text: $inputMinutes)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.frame(width: 100)
				
				if timerModel.isRunning {
					Text("Time Left: \(timerModel.timeRemaining) sec")
				}
				
				Button("Start Timer") {
					if let minutes = Int(inputMinutes) {
						timerModel.startTimer(seconds: minutes )
//						timerModel.startTimer(seconds: minutes * 60)
					}
				}
			}
			.padding()
			
			if timerModel.showAlert {
				IncomingCallView {
					timerModel.stopAlert()
				}
				.transition(.move(edge: .bottom))
				.animation(.spring(), value: timerModel.showAlert)
			}
		}
		.frame(minWidth: 300, minHeight: 200)
	}
}


#Preview {
    ContentView()
}
