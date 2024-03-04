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
    case sponsors
}

struct CarouselView: View {
    let viewsArray : [Views] = [.theme,.couleur,.logo,.teams,.sponsors,.theme]
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    @State private var selectedView: Int = 0
    
    var body: some View {
        GeometryReader {
            geometry in
            
            ZStack(alignment :.top) {
                Color("BackgroundColor").ignoresSafeArea()
                TabView(selection: $selectedView) {
                    // Step 6: Iterate Through Images
                    ForEach(0..<viewsArray.count, id: \.self) { index in
                        switch viewsArray[index] {
                        case .theme :
                            ThemeView()
                        case .couleur :
                            CouleurView()
                        case .logo :
                            LogoView()
                        case .teams :
                            TeamsView()
                        case .sponsors :
                            SponsorsView()
                        }
                    }
                }
                .frame(height: geometry.size.height*0.8) // Step 10: Set Carousel Height
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .onReceive(timer) { _ in
                // Step 16: Auto-Scrolling Logic
                withAnimation(.none) {
                    if (selectedView == viewsArray.count-1){
                        selectedView = 0
                    }
                }
                withAnimation(.default) {
                    selectedView = (selectedView + 1) % viewsArray.count
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
