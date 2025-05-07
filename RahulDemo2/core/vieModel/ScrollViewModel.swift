//
//  ScrollViewModel.swift
//  RahulDemo2
//
//  Created by Rahul Chaurasia on 06/05/25.
//

import Foundation

//we nedd only one field actually
class ScrollViewModel: ObservableObject {
    @Published var scrollOffset: CGFloat = 0 // for vCollapsingHeaderView1

    @Published var offset: CGFloat = 0   // offset for CollapsingHeaderView
}
