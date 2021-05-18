//
//  ContentView.swift
//  [NAH]Watch WatchKit Extension
//
//  Created by Jose Tlacuilo on 18/05/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var glosario = GlosarioWatch()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Text(glosario.palabra)
                        .bold()
                    Text(glosario.espPalabra)
                }
                .padding()
                .background(Color.accentColor)
                .cornerRadius(8.0)
                HStack {
                    Button(action: glosario.previous, label: {
                        Image(systemName: "chevron.left")
                        Spacer()
                    })
                    .buttonStyle(PlainButtonStyle())
                    Button(action: glosario.next, label: {
                        Spacer()
                        Image(systemName: "chevron.right")
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
