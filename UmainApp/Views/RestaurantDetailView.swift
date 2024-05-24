//
//  RestaurantDetailView.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-21.
//

import SwiftUI

struct RestaurantDetailView: View {
    @EnvironmentObject var graphics : GraphicsModel
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var restaurantVM : RestaurantViewModel
    @Binding var showDetailView : Bool
    
    let restaurant: Restaurant
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .leading) {
                
                AsyncImage(url: URL(string: restaurant.imageURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.size.width)
                    
                } placeholder: {
                    ProgressView()
                }
                .ignoresSafeArea()
                
                Image("Chevron")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, alignment: .topLeading)
                    .padding(.leading, 22)
                    .offset(y: -110)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation {
                            dismiss()
                        }
                        
                    }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 15.0)
                        .frame(height: 144)
                        .padding(.horizontal, 16)
                        .foregroundColor(graphics.useColor(for: .background))
                        .background(Color.black
                            .opacity(0.06)
                            .shadow(color: .black, radius: 3, x: 0, y: 4)
                            .blur(radius: 8, opaque: false)
                        )
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(restaurant.name)
                            .font(.system(size: 24))
                            .foregroundStyle(graphics.useColor(for: .darkText))
                        
                        Text(restaurantVM.getFilterDescription(for: restaurant))
                            .font(.custom("helvetica", size: 16).bold())
                            .foregroundStyle(graphics.useColor(for: .subtitle))
                            .multilineTextAlignment(.leading)
                            .padding(.trailing, 32)
                        
                        HStack(spacing: 0) {
                            Text(restaurantVM.isRestaurantOpen ? "Open" : "Closed")
                                .font(.system(size: 16))
                                .foregroundStyle(graphics.useColor(for: restaurantVM.isRestaurantOpen ? .positive : .negative))
                            
                            Spacer()
                        }
                    }
                    .padding(.leading, 32)
                }
                .offset(y: (UIScreen.main.bounds.minY + 80))
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .onAppear(perform: {
            restaurantVM.fetchRestaurantIfOpen(restaurantId: restaurant.id)
        })
        
        
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.height > 100 {
                        dismiss()
                    }
                }
        )
        
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let restaurant = Restaurant(
            id: "7450001",
            filterIDS: [
                "5c64dea3-a4ac-4151-a2e3-42e7919a925d",
                "614fd642-3fa6-4f15-8786-dd3a8358cd78",
                "c67cd8a3-f191-4083-ad28-741659f214d7",
                "23a38556-779e-4a3b-a75b-fcbc7a1c7a20"
            ],
            deliveryTimeMinutes: 9,
            rating: 4.6,
            name: "Wayne \"Chad Broski\" Burgers",
            imageURL: "https://food-delivery.umain.io/images/restaurant/burgers.png")
        
        @State var showDetailView = true
        
        RestaurantDetailView(showDetailView: $showDetailView, restaurant: restaurant)
            .environmentObject(GraphicsModel())
            .environmentObject(RestaurantViewModel())
    }
}
