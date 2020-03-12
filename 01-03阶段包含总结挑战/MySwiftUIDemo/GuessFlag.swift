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
    
    // 增加旁白支持 不支持中文????
    #if false
    let labels = [
        "Estonia": "旗帜上有三个相等大小的水平条纹。顶部条纹为蓝色，中间条纹为黑色，底部条纹为白色",
        "France": "旗帜上有三个相等大小的垂直条纹。左条纹为蓝色，中间条纹为白色，右条纹为红色",
        "Germany": "旗帜上有三个相等大小的水平条纹。顶部条纹黑色，中间条纹红色，底部条纹金色",
        "Ireland": "旗帜上有三个相等大小的垂直条纹。左条纹绿色，中间条纹白色，右条纹橙色",
        "Italy": "旗帜上有三个相等大小的垂直条纹。左条纹为绿色，中间条纹为白色，右条纹为红色",
        "Nigeria": "旗帜上有三个相等大小的垂直条纹。左条纹绿色，中间条纹白色，右条纹绿色",
        "Poland": "旗帜上有两个相等大小的水平条纹。顶部条纹白色，底部条纹红色",
        "Russia": "旗帜上有三个相等大小的水平条纹。顶部条纹白色，中间条纹蓝色，底部条纹红色",
        "Spain": "旗帜上有三个水平条纹。顶部细条纹红色，中间粗条纹金色，左侧带有峰顶，底部细条纹红色",
        "UK": "旗帜上带有重叠的红色和白色十字架，在蓝色背景上的直线和对角线",
        "US": "旗帜上有大小相等的红色和白色条纹，在左上角的蓝色背景上带有白色星星"
    ]
    #else
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    #endif

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
                        //Text("请点击正确的国旗")
                        Text("Tap the flag")
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
                                .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
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

