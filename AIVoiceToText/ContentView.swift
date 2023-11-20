//
//  ContentView.swift
//  AIVoiceToText
//
//  Created by John goodstadt on 05/11/2023.
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var speechRecognizer = SpeechRecognizer()
	@State private var transscribedText = "Spoken text will appear here"
	
    var body: some View {
		VStack {
			
			Text(transscribedText)
				.padding()
				.padding([.bottom,.top],40)
			
			Text("Press and speak")
				.padding()
				.padding(.bottom,20)
			
			Button(action: {
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //need more time to capture last word (1/2 a second)
					stopTranscribing()
					let text = speechRecognizer.transcript
					self.transscribedText = text
				}
				
			}) {
				ZStack {
					Image(systemName: "mic")
						.frame(height: 60)
						.imageScale(.large)
						.foregroundColor(.accentColor)
						.font(.system(size: 60))
						.padding()
				}
			}
			.simultaneousGesture(
				LongPressGesture(minimumDuration: 0.1).onEnded({_ in
					startTranscribing()
				})
			)
			Spacer()
		}
    }
	func startTranscribing(){
		speechRecognizer.resetTranscript()
		speechRecognizer.startTranscribing()
	}
	func stopTranscribing(){
		speechRecognizer.stopTranscribing()
	}
}

#Preview {
    ContentView()
}
