//
//  UseHapticsDemo.swift
//  Flashzilla_17
//
//  Created by DR_Kun on 2020/3/14.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct UseHapticsDemo: View {
    var body: some View {
        VStack {
            SimpleUseUINotificationFeedbackGenerator()
                .padding(.bottom)
            SimpleUseCoreHapticsDemoe()
        }
        
    }
}

struct UseHapticsDemo_Previews: PreviewProvider {
    static var previews: some View {
        UseHapticsDemo()
    }
}

// 使用触感 UINotificationFeedbackGenerator (iPhone 7, iPhone 7 Plus 以及之后的机型支持,2016年9月之后的机型)
struct SimpleUseUINotificationFeedbackGenerator: View {
    var body: some View {
        Text("LongPress To Feedback")
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .contextMenu {
                Button("success") {
                    self.simpleNofiticationFeedbackGenertor(.success)
                }
                Button("warning") {
                    self.simpleNofiticationFeedbackGenertor(.warning)
                }
                Button("error") {
                    self.simpleNofiticationFeedbackGenertor(.error)
                }
        }
    }
    private func simpleNofiticationFeedbackGenertor(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
}

import CoreHaptics

struct SimpleUseCoreHapticsDemoe: View {
    
    @State private var engine: CHHapticEngine?
    
    
    var body: some View {
        Text("Use CoreHaptics")
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .onAppear(perform: prepareHaptics)
            .onTapGesture(perform: complexSuccess)
    }
    
    func prepareHaptics() {
        // 检查设备是否支持
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        // 检查设备是否支持
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        /*
         // 震动的强度
         let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
         // 震动的锐利度
         let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
         let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
         events.append(event)
         */
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
    
}
