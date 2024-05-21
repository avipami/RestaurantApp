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
    
    @ObservedObject var viewModel = ButtonViewModel()
    @EnvironmentObject var graphics : GraphicsModel
    
    var body: some View {
        
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: viewModel.buttonHeight/2)
                    .foregroundStyle(isSelected ? .orange : .white)
                    .frame(width: viewModel.buttonWidth, height: viewModel.buttonHeight)
                
                AsyncImage(url: URL(string: filter.image_url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                } placeholder: {
                    ProgressView()
                }
                
                Text(filter.name)
                    .font(Font.custom("inter", size: 16))
                    .foregroundColor(graphics.useColor(for: .darkText))
                    .padding(.leading, 55)
            }
            .frame(width: viewModel.buttonWidth, height: viewModel.buttonHeight)
            .background(Color.black
                .opacity(0.06)
                .shadow(color: .black, radius: 3, x: 0, y: 4)
                .blur(radius: 8, opaque: false)
            )
            .frame(width: viewModel.buttonWidth, height: viewModel.buttonHeight + 20)
            
            .padding(.leading, 21)
            
        }
        .onTapGesture {
            isSelected.toggle()
        }
    }
}

#Preview {
    let graphics = GraphicsModel()
    let viewModel = ButtonViewModel()
    @State var buttonState = false
    
    return FilterItemView(
        filter: Filter(id: "c67cd8a3-f191-4083-ad28-741659f214d7", name: "Take-Out", image_url: "https://food-delivery.umain.io/images/filter/filter_take_out.png"),
        isSelected: $buttonState,
        viewModel: viewModel
        
    ).environmentObject(graphics)
}
