//
//  FilterView.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-20.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var restaurantVM: RestaurantViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(restaurantVM.filters) { filter in
                    FilterItemView(filter: filter, isSelected: binding(for: filter))
                }
            }.padding(.trailing, 16)
        }
    }
    
    private func binding(for filter: Filter) -> Binding<Bool> {
        Binding<Bool>(
            get: { restaurantVM.selectedFilters.contains(filter.id) },
            set: { isSelected in
                restaurantVM.toggleFilter(filter)
            }
        )
    }
}
