//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by HTLILI on 07/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.5, blue: 3), location: 0.3),
                .init(color: Color(CGColor(red: 0.1, green: 1, blue: 0.1, alpha: 1)), location: 0.3)
            ], center: .top, startRadius: 150, endRadius: 700)
            .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle).bold()
                
                VStack(spacing: 20) {
                    VStack {
                        Text(scoreTitle)
                        
                        Text("Tap the flag of")
                        
                            .foregroundColor(.secondary)
                            .font(.title.weight(.bold))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.heavy))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 10)
                        }
                    }
                    .padding()
                }
                
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 50))
                
                
                Spacer()
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
            
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
            } message: {
                Text("Yor score is \(scoreTitle)")
            }
        }
        
    }
    func flagTapped(_ number: Int) {
        if correctAnswer == number && score < countries.count {
            scoreTitle = "Correct Well Done"
            score += 1
        } else {
            scoreTitle = "Wrong Sorry"
        
        }
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
