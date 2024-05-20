//
//  FilterItemView.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-20.
//

import SwiftUI

struct FilterItemView: View {
    let filter: Filter
    var isSelected: Bool
    
    @ObservedObject var viewModel = ButtonViewModel()
    @EnvironmentObject var graphics : GraphicsModel
    
    var body: some View {
        
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: viewModel.buttonHeight/2)
                    .foregroundStyle(viewModel.isSelected ? graphics.useColor(for: .selectedButton) : graphics.useColor(for: .background))
                    .frame(width: viewModel.buttonWidth, height: viewModel.buttonHeight)
                
                    .onTapGesture {
                        viewModel.isSelected.toggle()
                    }
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
    }
}

struct FilterItemView_Previews: PreviewProvider {
    static var previews: some View {
        let graphicsModel = GraphicsModel()
        Home()
            .environmentObject(graphicsModel)
    }
}
