//
//  CarouselView.swift
//  Carivederci
//
//  Created by Maxime on 25/02/2024.
//

import SwiftUI

enum Views {
    case theme
    case couleur
    case logo
    case teams
}

struct CarouselView: View {
    let viewsArray : [Views] = [.theme,.couleur,.logo,.teams]
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    @State private var selectedView: Int = 0
    
    var body: some View {
        GeometryReader {
            geometry in
            
            ZStack(alignment :.top) {
                Color("BackgroundColor").ignoresSafeArea()
                TabView(selection: $selectedView) {
                    Spacer().tag(-1)
                    ForEach(viewsArray.indices, id: \.self) { index in
                        switch viewsArray[index] {
                        case .theme :
                            ThemeView().tag(index)
                        case .couleur :
                            CouleurView().tag(index)
                        case .logo :
                            LogoView().tag(index)
                        case .teams :
                            TeamsView().tag(index)
                        }
                    }
                    Spacer().tag(viewsArray.count)
                }
                .frame(height: geometry.size.height*0.8)                 .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onTapGesture(){
                    timer.upstream.connect().cancel()
                }
                .onChange(of : selectedView){_ in
                    if selectedView == viewsArray.count {
                        selectedView = 0
                    } else if selectedView == -1 {
                        selectedView = viewsArray.count-1
                    }
                }
                .onReceive(timer) { _ in
                    withAnimation(.none){
                        if selectedView == viewsArray.count-1 {
                            selectedView = -1
                        }
                    }
                    withAnimation(.default) {
                        selectedView = (selectedView + 1)%viewsArray.count
                    }
                }
            }
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
    }
}
