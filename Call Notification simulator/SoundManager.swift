//
//  SoundManager.swift
//  Call Notification simulator
//
//  Created by harsh  on 17/04/25.
//

import AVFoundation

class SoundManager {
	static let shared = SoundManager()
	
	var player: AVAudioPlayer?
	
	func startLooping() {
		guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else { return }
		do {
			player = try AVAudioPlayer(contentsOf: url)
			player?.numberOfLoops = -1 // Loop forever
			player?.play()
		} catch {
			print("Error playing sound: \(error)")
		}
	}
	
	func stop() {
		player?.stop()
	}
}
