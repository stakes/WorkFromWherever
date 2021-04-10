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
    @State var yOffset: CGFloat = 4
    @State var isTooltip: Bool = false
    @State var isDragging: Bool = false
    @State var channelListViewModel:ChannelListViewModel
    @Binding var channel: Channel
    @Binding var sound: Sound
    @Binding var value: CGFloat
    var label: String
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack {
                RoundedRectangle(cornerRadius: 40).fill(Color("backgroundColor"))
                    .shadow(color: .black, radius: 10, x: 5, y: 5)
                    .shadow(color: .white, radius: 10, x: -5, y: -5)
                    .blendMode(.overlay)
                RoundedRectangle(cornerRadius: 40).fill(Color("backgroundColor"))
                GeometryReader { geometry in
                    VStack {
                        ZStack {
                            Circle()
                                .shadow(color: .black, radius: 10, x: 5, y: 5)
                                .shadow(color: .white, radius: 10, x: -5, y: -5)
                                .blendMode(.overlay)
                            Circle()
                                .fill(Color("knobColor"))
                                .overlay(Circle().stroke(Color("lightenedBgColor"), lineWidth: 3))
                                .onHover { inside in
                                    if inside {
                                        isTooltip = true
                                        NSCursor.pointingHand.push()
                                    } else {
                                        if !isDragging {
                                            isTooltip = false
                                        }
                                        NSCursor.pop()
                                    }
                                }
                                Tooltip(label: self.label).frame(width: 38).offset(y: -46).opacity(isTooltip ? 1 : 0).animation(.easeInOut)
                            
                        }
                        .frame(width: 38, height: 38)
                        .offset(y: yOffset)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    if abs(value.translation.height) < 0.1 {
                                        self.lastOffset = self.yOffset
                                    }
                                    let sliderPos = max(4, min(lastOffset + (value.translation.height), (geometry.size.height) - 4 - 38))
                                    self.yOffset = sliderPos
                                    let sliderVal = sliderPos.mapInverse(from: 4...((geometry.size.height) - 4 - 38), to: 0...1)
                                    self.value = sliderVal
                                    if !isTooltip {
                                        isTooltip = true
                                    }
                                    isDragging = true
                                }
                                .onEnded { _ in
                                    isTooltip = false
                                    isDragging = false
//                                    cvm.updateVolumeForSound(channel: channel, sound: sound, value: value)
                                    channelListViewModel.update(channel: channel, sound: sound, volume: value)
                                }
                        ).onAppear() {
                            let v = value.mapInverse(from: 0...1, to: 4...((geometry.size.height) - 4 - 38))
                            self.yOffset = v
                        }
                        Spacer()
                    }.frame(width: 44, height: 130)
                }
            }.frame(width: 44, height: 130)
        }.frame(width: 86, height: 172).background(Color("backgroundColor"))
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

//struct FaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        FaderView(value: .constant(0), label: "Sound Name")
//    }
//}

extension View {
    func innerShadow<S: Shape>(using shape: S, angle: Angle = .degrees(0), color: Color = .black, width: CGFloat = 6, blur: CGFloat = 6) -> some View {
        return self
    }
}
