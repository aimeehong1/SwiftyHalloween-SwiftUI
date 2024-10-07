//
//  ContentView.swift
//  SwiftyHalloween
//
//  Created by Aimee Hong on 10/7/24.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var imageName = ""
    @State private var soundName = ""
    @State private var message = ""
    @State private var audioPlayer: AVAudioPlayer!
    private let imageNames = ["corona", "ghost", "bat", "spider", "vampire", "witch", "pumpkin", "skull", "david", "house"]
    private let messages = ["It is certain",
                            "It is decidedly so",
                            "Without a doubt",
                            "Yes, definitely",
                            "You may rely on it",
                            "As I see it, yes",
                            "Most likely",
                            "Outlook good",
                            "Yes",
                            "Signs point to yes",
                            "Reply hazy try again",
                            "Ask again later",
                            "Better not tell you now",
                            "Cannot predict now",
                            "Concentrate and ask again",
                            "Don't count on it",
                            "My reply is no",
                            "My sources say no",
                            "Outlook not so good",
                            "Very doubtful"]
    var body: some View {
        VStack {
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .animation(.default, value: imageName)
            
            Spacer()
            
            Text(message)
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .frame(height: 80)
                .minimumScaleFactor(0.5)
                .animation(.default, value: message)
            
            Spacer()
            
            Button("🎃 Predict") {
                let lastMessage = message
                let lastImage = imageName
                repeat {
                    message = messages.randomElement()!
                } while message == lastMessage
                repeat {
                    imageName = imageNames.randomElement()!
                } while imageName == lastImage
                playSound(soundName: "\(imageName)_sound")
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .foregroundStyle(.black)
            .font(.title)
        }
        .padding()
    }
    func playSound(soundName: String) {
            if audioPlayer != nil {
                audioPlayer.stop()
            }
            guard let soundFile = NSDataAsset(name: soundName) else {
                print("😡 Could not read file named \(soundName)")
                return
            }
            do {
                audioPlayer = try AVAudioPlayer(data: soundFile.data)
                audioPlayer.play()
            } catch {
                print("😡 ERROR: \(error.localizedDescription) creating audioplayer.")
            }
        }

}

#Preview {
    ContentView()
}
