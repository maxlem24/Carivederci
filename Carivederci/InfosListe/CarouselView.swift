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
    let viewsArray : [Views] = [.theme,.teams,.youtube]
    @State var timer = Timer.publish(every: 5.0, on: .main, in: .common).autoconnect()
    
    @State private var selectedView: Int = 0
    @Binding var header : String
    var body: some View {
        GeometryReader {
            geometry in
            
            ZStack(alignment :.top) {
                Color("BlancRosé").ignoresSafeArea()
                TabView(selection: $selectedView) {
                    Spacer().tag(-1)
                    ForEach(viewsArray.indices, id: \.self) { index in
                        switch viewsArray[index] {
                        case .theme :
                            ThemeView().tag(index)
                                .onAppear(perform: {header = "Carivederci c'est :"})
                        case .teams :
                            TeamsView().tag(index)
                                .onAppear(perform: {header = "Nos poles"})
                        case .youtube :
                            YoutubeView().tag(index)
                                .onAppear(perform: {header = "Notre chaine Youtube"})
                        }
                    }
                    Spacer().tag(viewsArray.count)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
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
            .onAppear(perform : {
                timer = Timer.publish(every: 5.0, on: .main, in: .common).autoconnect()
            })
            .onDisappear(perform: {
                timer.upstream.connect().cancel()
            })
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(header: .constant(""))
    }
}
