//
//  GuessFlag.swift
//  MySwiftUIDemo
//
//  Created by DR_Kun on 2020/3/1.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI


struct GuessFlag: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var isCorrect = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    
    private var rotationAmount: Double {
        if isCorrect {
            
        }
        return 0
    }
    
    private func calculateRotateAmount(_ number: Int) -> Double {
        if isCorrect {
            if number == correctAnswer {
                return 360
            }
        }
        return 0
    }
    
    private func calculateOpcity(_ number: Int) -> Double {
        guard showingScore else {
            return 1
        }
        if isCorrect {
            if number == correctAnswer {
                return 1
            }
        }
        return 0.25
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            withAnimation {
                isCorrect = true
            }
        } else {
            scoreTitle = "Wrong"
            if score > 0 {
                score -= 1
            } else {
                score = 0
            }
            isCorrect = false
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        isCorrect = false
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            // flag was tapped
                            self.flagTapped(number)
                        }) {
                            FlagImage(name: self.countries[number])
                        }
                        .rotation3DEffect(.degrees(self.calculateRotateAmount(number)), axis: (x: 0, y: 1, z: 0))
                        .opacity(self.calculateOpcity(number))
                    }
                    
                    Spacer()
                }
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(self.score)"), dismissButton: .default(Text("Continue"), action: {
                    self.askQuestion()
                }))
            }
            .navigationBarTitle(Text("Guess Flag"))
        }
    }
}

fileprivate struct FlagImage: View {
    fileprivate let name: String
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}


struct GuessFlag_Previews: PreviewProvider {
    static var previews: some View {
        GuessFlag()
    }
}

