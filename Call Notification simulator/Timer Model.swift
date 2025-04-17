//
//  Timer Model.swift
//  Call Notification simulator
//
//  Created by harsh  on 17/04/25.
//

import Foundation
import Combine

class TimerModel: ObservableObject {
	@Published var timeRemaining: Int = 0
	@Published var isRunning = false
	@Published var showAlert = false
	
	var timer: Timer?
	
	func startTimer(seconds: Int) {
		timeRemaining = seconds
		isRunning = true
		showAlert = false
		
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
			self.timeRemaining -= 1
			if self.timeRemaining <= 0 {
				self.timer?.invalidate()
				self.isRunning = false
				self.showAlert = true
				SoundManager.shared.startLooping()
			}
		}
	}
	
	func stopAlert() {
		showAlert = false
		SoundManager.shared.stop()
	}
}
