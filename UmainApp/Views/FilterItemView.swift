//
//  FilterItemView.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-20.
//

import SwiftUI

struct FilterItemView: View {
    let filter: Filter
    @Binding var isSelected: Bool
    @State var size: CGSize = .zero
    @EnvironmentObject var graphics: GraphicsModel
    
    var body: some View {
        
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: FilterButtonSpec.cornerRadius)
                    .foregroundStyle(isSelected ? graphics.useColor(for: .selected) : graphics.useColor(for: .background))
                
                AsyncImage(url: URL(string: filter.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                } placeholder: {
                    ProgressView()
                }
                
                Text(filter.name)
                    .font(Font.custom("Poppins-Medium", size: 14))
                    .foregroundColor(isSelected ? graphics.useColor(for: .lightText) : graphics.useColor(for: .darkText))
                    .padding(.leading, 55)
                
            }
            .frame(width: FilterButtonSpec.buttonWidth, height: FilterButtonSpec.buttonHeight)
            .background(Color.black
                .opacity(0.06)
                .shadow(color: .black, radius: 3, x: 0, y: 4)
                .blur(radius: 8, opaque: false)
            )
            .frame(width: FilterButtonSpec.buttonWidth, height: FilterButtonSpec.buttonHeight + 20)
            
            .padding(.leading, 21)
            
        }
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

#Preview {
    @State var buttonState = false
    
    return FilterItemView(
        filter: Filter(id: "c67cd8a3-f191-4083-ad28-741659f214d7", name: "Take-Out", imageUrl: "https://food-delivery.umain.io/images/filter/filter_take_out.png"),
        isSelected: $buttonState
    )
    .environmentObject(GraphicsModel())
}
