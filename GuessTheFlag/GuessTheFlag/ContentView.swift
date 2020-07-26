//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by DHK on 2020/07/26.
//  Copyright © 2020 DHK. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var scoreShowing = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    
    var body: some View {
        ZStack {
            // blue gradient background
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.title)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text("Current Score: \(userScore)")
                        .foregroundColor(.white)
                        .font(.title)
                }
                ForEach(0 ..< 3) { number in Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule()) // rounds the edges
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1)) // border around image
                            .shadow(color: .black, radius: 2)
                    }
                }
            } // VStack
        } // ZStack
            .alert(isPresented: $scoreShowing) {
                Alert(title: Text(scoreTitle), message: Text("Your Score is \(userScore)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                })
            }
    } // body
    
    func flagTapped (_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            userScore += 1
        } else {
            scoreTitle = "Wrong. That is the flag of \(countries[number])."
        }
        scoreShowing = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
