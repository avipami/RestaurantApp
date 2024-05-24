//
//  RestaurantCardView.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-15.
//

import SwiftUI

struct RestaurantCardView: View {
    @EnvironmentObject var graphics : GraphicsModel
    @EnvironmentObject var restaurantVM: RestaurantViewModel
    let restaurant: Restaurant
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: restaurant.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
            } placeholder: {
                ProgressView()
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack {
                Spacer()
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 64)
                    .foregroundColor(graphics.useColor(for: .background))
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text(restaurant.name)
                                .foregroundStyle(graphics.useColor(for: .darkText))
                            .padding(.leading, 5)
                            
                            Spacer()
                            
                            Image("Star")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 12, height: 12)
                            Text(String(format: "%.1f", restaurant.rating))
                                .font(Font.custom("Inter", size: 10))
                                .padding(.trailing, 8)
                            
                        }
                        
                        Text(restaurantVM.getFilterDescription(for: restaurant))
                            .font(.custom("Helvetica", size: 12).bold())
                            .foregroundStyle(graphics.useColor(for: .subtitle))
                            .padding(.leading, 5)
                        HStack(spacing: 0) {
                            Image("DeliveryTime")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 10)
                                .padding(.trailing, 3)
                            Text("\(restaurant.deliveryTimeMinutes) min")
                                .font(.system(size: 10))
                                .foregroundStyle(graphics.useColor(for: .darkText))
                            
                            Spacer()
                        }.padding(.leading, 5)
                    }
                }
            }
        }
        .frame(height: 196)
        .padding(.horizontal, 16)
    }
}

struct RestaurantCardView_Previews: PreviewProvider {
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
        
        RestaurantCardView(restaurant: restaurant)
            .environmentObject(GraphicsModel())
            .environmentObject(RestaurantViewModel())
    }
}
