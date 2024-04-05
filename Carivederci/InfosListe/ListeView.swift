//
//  ThemeView.swift
//  Carivederci
//
//  Created by Maxime on 25/02/2024.
//

import SwiftUI

struct ListeView: View {
    var body: some View {
            GeometryReader{
                geometry in
                ZStack{
                    Color("BlancRosé").ignoresSafeArea()
                    VStack {
                        Text("Cariverderci c'est")
                            .font(.title).foregroundColor(Color("Marron")).padding()
                            .frame(width: geometry.size.width, height: geometry.size.height*0.1)
                            .background(Rectangle().fill(Color("RosePale")).cornerRadius(10))
                        Spacer()
                        HStack{
                            Spacer()
                            Image("Logo").resizable().scaledToFit().frame(width: geometry.size.height*0.4, height: geometry.size.height*0.4).padding(.vertical,20)
                            Spacer()
                        }
                        ScrollView{
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla iaculis tortor ut nisl pharetra, at porttitor est semper. Sed a pharetra nulla, et mattis felis. Nunc porta magna vitae interdum luctus. Cras pharetra magna in velit condimentum mattis. Nunc consectetur neque nec ex convallis, sodales bibendum dui ullamcorper. Donec consectetur ligula ac orci cursus malesuada. Nunc in feugiat sem, eget sollicitudin magna. Proin et ligula id quam volutpat cursus. In consectetur porta risus, cursus pretium odio faucibus et. Sed iaculis arcu enim, efficitur aliquet ligula tempor et. Integer sodales commodo mi sed condimentum. Donec ut interdum massa, sit amet cursus ligula. Vivamus malesuada suscipit lorem, vel sollicitudin lacus facilisis ac. Nulla augue tellus, condimentum sit amet consectetur eget, tempus in nisl.")
                                .font(.body).foregroundColor(Color("Marron")).multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/).frame(width : geometry.size.width*0.9)
                            Spacer()
                        Text("\"Slogan qui claque\"").italic().font(.title3).multilineTextAlignment(.center).frame(width : geometry.size.width*0.9)
                            Spacer()
                        }
                    }
                }
            }
    }
}

struct ListeView_Previews: PreviewProvider {
    static var previews: some View {
        ListeView()
    }
}
