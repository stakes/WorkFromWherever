//
//  Tooltip.swift
//  WorkFromWherever
//
//  Created by Jay Stakelon on 3/20/21.
//

import SwiftUI

struct TooltipView: View {
    var label: String
    var body: some View {
        HStack(alignment: .bottom) {
            HStack {
                Text(self.label).foregroundColor(Color.white).font(.system(size: 11, design: .monospaced)).fixedSize(horizontal: true, vertical: false).multilineTextAlignment(.center).padding(8)
            }.background(Color.black).cornerRadius(8)
        }.frame(height: 44, alignment: .bottom)
    }
}

struct Tooltip_Previews: PreviewProvider {
    static var previews: some View {
        TooltipView(label: "Clinkity Clankity")
    }
}
