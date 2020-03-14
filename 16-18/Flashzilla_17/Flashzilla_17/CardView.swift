//
//  CardView.swift
//  Flashzilla_17
//
//  Created by DR_Kun on 2020/3/14.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI


/**
 * 为了改善这一点，我们需要在调用 `play()` 之前先在触觉上调用 `prepare()` 。
 * 在 `play()` 之前立即调用 `prepare()` 是不够的：这样做并没有给 `Taptic Engine` 足够的时间进行预热，
 * 因此您不会看到延迟减少。
 * 相反，您应该在知道可能需要触觉后立即调用 `prepare()` 。
 *
 * 现在，您应该注意两个有用的实现细节。
 *
 * 首先，可以调用 `prepare()` ，然后再也不要调用 `play()`
 * 系统将使 `Taptic Engine` 保持几秒钟的准备时间，然后再次将其关闭。
 * 如果您反复调用 `prepare()` 而从不调用 `play()` ，
 * 则系统可能会开始忽略您的 `prepare()` 调用，直到至少发生一次 `play()` 为止。
 *
 * 其次，完全可以在一次调用 `play()` 之前多次调用 `prepare()`
 *  `Taptic Engine` 预热时 `prepare()` 不会暂停您的应用，
 * 并且当系统已经运行时也没有任何实际的性能成本准备好了。
 *
 * 将这两者放在一起，我们将更新拖动手势，以便每当手势更改时都会调用 `prepare()` 。
 * 这意味着可以在最终调用 `play()` 之前调用它一百次，
 * 因为每次用户移动手指时都会触发它。
 *
 */


struct CardView: View {
    let card: Card
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    // 旁白
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var isShowingAnswer = false
    
    @State private var offset = CGSize.zero
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var removal: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    self.differentiateWithoutColor ?
                        Color.white :
                        Color.white
                            .opacity(1 - Double(abs(offset.width / 50)))
            )
                .background(
                    differentiateWithoutColor ?
                        nil :
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(offset.width > 0 ? Color.green : Color.red)
            )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibility(addTraits: .isButton)
        .onTapGesture {
            self.isShowingAnswer.toggle()
        }
        .gesture(
            DragGesture()
                .onChanged { (gesture) in
                    self.offset = gesture.translation
                    self.feedback.prepare()
            }
            .onEnded{ gesture in
                if abs(self.offset.width) > 100 {
                    if self.offset.width > 0 {
                        self.feedback.notificationOccurred(.success)
                    } else {
                        self.feedback.notificationOccurred(.error)
                    }
                    self.removal?()
                } else {
                    self.offset = .zero
                }
            }
        )
    }
}


struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
