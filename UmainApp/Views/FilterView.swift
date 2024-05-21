//
//  FilterView.swift
//  UmainApp
//
//  Created by Vincent Palma on 2024-05-20.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var viewModel: RestaurantViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.filters) { filter in
                    
                    FilterItemView(filter: filter, isSelected: Binding<Bool>(
                        get: { viewModel.selectedFilter == filter.id },
                        set: { isSelected in
                            viewModel.toggleFilter(filter)
                        }
                    ))
                }
            }
        }
    }
}
