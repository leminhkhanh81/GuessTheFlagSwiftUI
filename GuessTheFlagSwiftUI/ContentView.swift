//
//  ContentView.swift
//  GuessTheFlagSwiftUI
//
//  Created by Le Minh Khanh on 26/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var reset = false
    @State private var answerCount = 1
    @State private var scoreTitle = ""
    @State private var score = 0.0
    @State private var flagSeleted = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            Spacer()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack (spacing: 15){
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    } //: VSTACK
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(color:.secondary, radius: 5)
                        }
                    } //: FOREACH
                } //: VSTACK
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                Text("Score: \(score.formatted(.number))")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
                Spacer()
            } //: VSTACK
            .padding()
        } //: ZSTACK
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("That’s the flag of \(countries[flagSeleted])")
        }
        .alert("Congratulations", isPresented: $reset) {
            Button("Start again", action: resetGame)
        } message: {
            Text("Your score is: \(score.formatted(.number))")
        }
    } //: BODY
    
    //MARK: - FUNCTION
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            if score > 0 {
                score -= 0.5
            }
        }
        flagSeleted = number
        answerCount += 1
        showingScore = true
        if answerCount > 2 {
            reset = true
        }
//        showingScore = true
    }
    
    func resetGame() {
        showingScore = false
        scoreTitle = ""
        score = 0.0
        answerCount = 1
        askQuestion()
    }
    
    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
