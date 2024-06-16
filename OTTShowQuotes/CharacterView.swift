//
//  CharacterView.swift
//  OTTShowQuotes
//
//  Created by Ishaan Das on 15/06/24.
//

import SwiftUI

struct CharacterView: View {
    let character: Character
    let show: String
    var body: some View {
        GeometryReader { geo in
            ScrollViewReader { proxy in
                ZStack(alignment: .top){
                    Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0.6),Gradient.Stop(color: .black, location: 1)], startPoint: .top, endPoint: .bottom)
                        }
                    ScrollView{
                        TabView{
                            ForEach(character.images, id: \.self){ characterImageURL in
                                AsyncImage(url: characterImageURL) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(width: geo.size.width/1.2, height: geo.size.height/1.7)
                        .clipShape(.rect(cornerRadius: 25))
                        .padding(.top,60)
                        
                        VStack(alignment: .leading){
                            Text(character.name)
                                .font(.largeTitle)
                                .bold()
                            
                            Text("Portrayed By: \(character.portrayedBy)")
                                .font(.subheadline)
                            
                            Divider().background(.secondary)
                            
                            Text("\(character.name) Character Info")
                                .font(.title2)
                            Text("Born: \(character.birthday)")
                            
                            Divider().background(.secondary)
                            
                            Text("Occupations:")
                            ForEach(character.occupations, id: \.self){ occupation in
                                Text("• \(occupation)")
                                    .font(.subheadline)
                            }
                            
                            Divider().background(.secondary)
                            
                            Text("Nicknames:")
                            
                            if character.aliases.count > 0 {
                                ForEach(character.aliases, id: \.self){ alias in
                                    Text("• \(alias)")
                                        .font(.subheadline)
                                }
                            }
                            else {
                                Text("None")
                            }
                            
                            Divider().background(.secondary)
                            
                            DisclosureGroup("Status (spoiler alert!)"){
                                VStack(alignment: .leading){
                                    Text(character.status)
                                        .font(.title2)
                                        .bold()
                                    if let death = character.death {
                                        AsyncImage(url: death.image) { image in
                                            image
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 15))
                                                .onAppear {
                                                    withAnimation{
                                                        proxy.scrollTo(1,anchor: .bottom)
                                                    }
                                                }
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        
                                        Text("How? : \(death.details)")
                                        
                                        Text("Last words: \"\(death.lastWords)\"")
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .tint(.primary)
                        }
                        .frame(width: geo.size.width/1.2, alignment: .leading)
                        .padding(.bottom, 50)
                        .id(1)
                        
                        
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .background(.black)
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: ViewModel().character, show: "Breaking Bad")
        .preferredColorScheme(.dark)
}
