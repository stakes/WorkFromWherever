//
//  FaderView.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 2/28/21.
//  https://priva28.medium.com/making-a-custom-slider-in-swiftui-db440cd6d88c
//

import SwiftUI

struct FaderView: View {
    @State var lastOffset: CGFloat = 0
    @State var yOffset: CGFloat = 6
    @Binding var value: CGFloat
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 30)
                    .foregroundColor(.gray)
                VStack {
                    Circle()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.white)
                        .offset(y: self.$value.wrappedValue.map(from: 1...100, to: 6...200))
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    if (abs(value.translation.height) < 0.1) {
                                        self.lastOffset = self.$value.wrappedValue.map(from: 1...100, to: 6...(geometry.size.height - 6 - 22))
                                    }
                                    let sliderPos = max(6, min(self.lastOffset + value.translation.height, geometry.size.height - 6 - 22))
                                    self.yOffset = sliderPos
                                    let sliderVal = sliderPos.mapInverse(from: 6...(geometry.size.height - 6 - 22), to: 0...1)
                                    self.value = sliderVal
                                }
                        )
                    Spacer()
                }
            }
        }.frame(width: 30)
    }
}

extension CGFloat {
    func map(from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let result = ((self - from.lowerBound) / (from.upperBound - from.lowerBound)) * (to.upperBound - to.lowerBound) + to.lowerBound
        return result
    }
    func mapInverse(from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let result = ((self - from.lowerBound) / (from.upperBound - from.lowerBound)) * (to.lowerBound - to.upperBound) + to.upperBound
        return result
    }
}

struct FaderView_Previews: PreviewProvider {
    static var previews: some View {
        FaderView(value: .constant(0))
    }
}
