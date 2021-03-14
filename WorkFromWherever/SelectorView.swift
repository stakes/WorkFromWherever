//
//  SelectorView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 3/13/21.
//

import SwiftUI

struct SelectorView: View {
    @State var places:[Place]
    @Binding var selectedPlaceIndex:Int
    var body: some View {
        VStack {
            HStack {
                Text(places[selectedPlaceIndex].title).font(.system(.title3, design: .monospaced)).foregroundColor(.white).padding(8).padding(.leading, 12).opacity(0.8)
                Spacer()
//                Button(action: {
//                    self.selectedPlaceIndex -= 1
//                    print(self.selectedPlaceIndex)
//
//                }) {
//                    Image(systemName: "chevron.left").foregroundColor(.white)
//                }.buttonStyle(PlainButtonStyle())
//                Button(action: {
//                    self.selectedPlaceIndex += 1
//                    print(self.selectedPlaceIndex)
//                }) {
//                    Image(systemName: "chevron.right").foregroundColor(.white)
//                }.buttonStyle(PlainButtonStyle())
                NavigationLink(
                    destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                    label: {
                        Button(action: {
                            self.selectedPlaceIndex -= 1
                            print(self.selectedPlaceIndex)

                        }) {
                            Image(systemName: "chevron.left").foregroundColor(.white)
                        }.buttonStyle(PlainButtonStyle())
                    })
                Button(action: {
                    self.selectedPlaceIndex -= 1
                    print(self.selectedPlaceIndex)

                }) {
                    Image(systemName: "chevron.left").foregroundColor(.white)
                }.buttonStyle(PlainButtonStyle())
                Button(action: {
                    self.selectedPlaceIndex += 1
                    print(self.selectedPlaceIndex)
                }) {
                    Image(systemName: "chevron.right").foregroundColor(.white)
                }.buttonStyle(PlainButtonStyle())
                .padding(.trailing, 8)
            }.background(LinearGradient(gradient: Gradient(colors: [Color("screenColorStart"), Color("screenColorStop")]), startPoint: .bottom, endPoint: .top))
            .cornerRadius(8.0)
            .padding(.top, 32)
            .padding(.horizontal)
        }.background(Color("backgroundColor"))
    }
}

struct SelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SelectorView(places: placeData, selectedPlaceIndex: .constant(0))
    }
}
