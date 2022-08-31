//
//  MapSettings.swift
//  MapTypesTutorial
//
//  Created by Leonardo on 30/08/2022.
//

import SwiftUI

final class MapSettings: ObservableObject {
    @Published var mapType = 0
    @Published var showElevation = 0
    @Published var showEmphasisStyle = 0
}
