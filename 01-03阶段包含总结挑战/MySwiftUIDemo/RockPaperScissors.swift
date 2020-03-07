//
//  RockPaperScissors.swift
//  MySwiftUIDemo
//
//  Created by DR_Kun on 2020/3/2.
//  Copyright © 2020 kun. All rights reserved.
//

import SwiftUI

struct RockPaperScissors: View {
    
    @State private var correctAnswer = Int.random(in: 0 ..< 3)
    @State private var showAlert = false // 显示结果开关
    @State private var isWin = false
    @State private var totalCount = 0
    @State private var score = 0
    
    private let actions = ["Rock", "Paper", "Scissors"]
    
    private func reloadAnswer() {
        correctAnswer = Int.random(in: 0 ..< 3)
    }
    
    private func reloadGame() {
        reloadAnswer()
        totalCount = 0
        score = 0
    }
    
    private var answerInfo: String {
        if totalCount == 0 {
            return "emm..."
        }
        return isWin ? "You win" : "You lose"
    }
    
    private func answerTapped(_ number: Int) {
        isWin = correctAnswer == number
        if isWin {
            score += 1
        }
        totalCount += 1
        if totalCount == 10 {
            showAlert = true
        } else {
            reloadAnswer()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("\(answerInfo)")
                            .font(.largeTitle)
                        Spacer()
                    }
                    .padding()
                    .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                    
                    HStack(alignment: .center) {
                        Image(systemName: "dot.square")
                            .foregroundColor(.red)
                            .padding(.leading, 16)
                        Text("Make your choces")
                            .font(.subheadline)
                        Spacer()
                    }
                    
                    ForEach(0 ..< actions.count) { number in
                        Button(action: {
                            self.answerTapped(number)
                        }) {
                            Text("\(self.actions[number])")
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(width: 300, height: 100)
                                .background(Color.blue)
                                .clipShape(Capsule())
                                .padding()
                        }
                    }
                    
                    Spacer()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("重新开始"), message: Text(("10局游戏中你的得分是\(score)")), dismissButton: .default(Text("继续"), action: {
                        self.reloadGame()
                    }))
                }
                .navigationBarTitle("Game")
            }
            .background(Color(red: 0.56, green: 0.69, blue: 0.21).edgesIgnoringSafeArea(.all))
        }
    }
}

struct RockPaperScissors_Previews: PreviewProvider {
    static var previews: some View {
        RockPaperScissors()
    }
}
