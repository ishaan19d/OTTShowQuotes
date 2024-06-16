//
//  FetchView.swift
//  OTTShowQuotes
//
//  Created by Ishaan Das on 15/06/24.
//

import SwiftUI

struct FetchView: View {
    let vm = ViewModel()
    let show: String
    @State var showCharacterInfo = false
    var body: some View {
        GeometryReader { geo in
            ZStack{
                Image(show.removeSpaceAndLowecase())
                    .resizable()
                    .frame(width: geo.size.width * 2.7, height: geo.size.height * 1.2)
                
                VStack {
                    VStack{
                        Spacer(minLength: geo.size.height/15)
                        
                        switch vm.status {
                        case .notStarted:
                            EmptyView()
                            
                        case .fetching:
                            ProgressView()
                            
                        case .successQuote:
                            Text("\"\(vm.quote.quote)\"")
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black.opacity(0.5))
                                .clipShape(.rect(cornerRadius: 25))
                                .padding(.horizontal)
                            
                            ZStack(alignment: .bottom){
                                AsyncImage(url: vm.character.images[0]) { image in
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
                            
                        case .successEpisode:
                            EpisodeView(episode: vm.episode)
                            
                        case .failed(let error):
                            Text(error.localizedDescription)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(.rect(cornerRadius: 15))
                                .padding()
                        }
                        
                        Spacer(minLength: 20)
                    }
                    HStack{
                        Button{
                            Task{
                                await vm.getQuoteData(for: show)
                            }
                        } label: {
                            Text("Get Random Quote")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(color:.black ,radius: 2)
                        }
                        
                        Spacer()
                        
                        Button{
                            Task{
                                await vm.getEpisode(for: show)
                            }
                        } label: {
                            Text("Get Random Episode")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .padding()
                                .background(Color("\(show.removeSpaces())Button"))
                                .clipShape(.rect(cornerRadius: 10))
                                .shadow(color:.black ,radius: 2)
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer(minLength: geo.size.height/9)
                }
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    FetchView(show: Constants.bcsName)
}
