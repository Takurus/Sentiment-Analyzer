//
//  ContentView.swift
//  Vibe Check
//
//  Created by Jack Farray on 2022-07-11.
//

import SwiftUI
import NaturalLanguage

struct ContentView: View {
    
    @State private var inputText: String = ""
    
    private var score: String {
        return analyzeSentiment(for: inputText)
    }
    
    private let tagger = NLTagger(
        tagSchemes: [.sentimentScore])
    
    private func analyzeSentiment(for stringToAnalyze: String) -> String {
        
        tagger.string = stringToAnalyze
         
        let (sentimentScore, _) = tagger.tag(at: stringToAnalyze.startIndex, unit: .paragraph, scheme: .sentimentScore)
        
        return sentimentScore?.rawValue ?? ""
    }

    var body: some View {
        
        VStack {
            
            Text("Sentiment Analyzer")
            .padding()
            
            
            TextField("Enter text",
                  text: $inputText)
            
            //Score will show coreML NLF results
            Text(score)
                .foregroundColor(setColor(for: score))
            
        }
        .font(.system(size: 40))
        .multilineTextAlignment(.center)
    }
    private func setColor(for score: String) -> Color {
        
        guard let value = Double(score) else {
            return Color.black
        }
        
        if (value > 0) {
            return Color.green
        }
        
        return Color.red 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
