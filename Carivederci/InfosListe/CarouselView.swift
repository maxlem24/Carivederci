//
//  CarouselView.swift
//  Carivederci
//
//  Created by Maxime on 25/02/2024.
//

import SwiftUI

enum Views {
    case theme
    case youtube
    case teams
}

struct CarouselView: View {
    let viewsArray : [Views] = [.youtube,.theme,.teams,.youtube,.theme]
    
    @State private var selectedView: Int = 1
    var body: some View {
        GeometryReader {
            geometry in
            
            ZStack(alignment :.bottom) {
                Color("BlancRosé").ignoresSafeArea()
                TabView(selection: $selectedView) {
                    ForEach(viewsArray.indices, id: \.self) { index in
                        switch viewsArray[index] {
                        case .theme :
                            ListeView()
                        case .teams :
                            TeamsView()
                        case .youtube :
                            YoutubeView()
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onChange(of : selectedView){_ in
                    withAnimation(.none){
                    if selectedView == viewsArray.count-1 {
                        selectedView = 1
                    } else if selectedView == 0 {
                        selectedView = viewsArray.count-2
                    }}
                }
                HStack {
                    Capsule().fill(Color.white.opacity(0.33))
                        .frame(width: geometry.size.width*0.25,height: 8)
                        .onTapGesture {
                            withAnimation(.default){
                                selectedView = selectedView - 1
                            }
                        }
                    Capsule().fill(Color.white)
                        .frame(width: geometry.size.width*0.25,height: 8)
                    Capsule().fill(Color.white.opacity(0.33))
                        .frame(width: geometry.size.width*0.25,height: 8)
                        .onTapGesture {
                            withAnimation(.default){
                                selectedView = selectedView + 1
                            }
                        }
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
            }
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
