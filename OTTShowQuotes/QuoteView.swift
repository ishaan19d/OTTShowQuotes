//
//  QuoteView.swift
//  OTTShowQuotes
//
//  Created by Ishaan Das on 17/06/24.
//

import SwiftUI

struct QuoteView: View {
    let quote: Quote
    let geo:
    var body: some View {
        Text("\"\(quote.quote)\"")
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .foregroundStyle(.white)
            .padding()
            .background(.black.opacity(0.5))
            .clipShape(.rect(cornerRadius: 25))
            .padding(.horizontal)
        
        ZStack(alignment: .bottom){
            AsyncImage(url: quote.character.images[0]) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
            
            Text(vm.quote.character)
                .foregroundStyle(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
            
        }
        .frame(width: geo.size.width/1.1, height: geo.size.height/1.8)
        .clipShape(.rect(cornerRadius: 50))
        .onTapGesture {
            showCharacterInfo.toggle()
        }
        .sheet(isPresented: $showCharacterInfo , content: {
            CharacterView(character: vm.character, show: show)
        })
    }
}

#Preview {
    QuoteView()
}
