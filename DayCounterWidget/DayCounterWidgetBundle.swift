//
//  DayCounterWidgetBundle.swift
//  DayCounterWidget
//
//  Created by admin on 9.02.24.
//

import WidgetKit
import SwiftUI

@main
struct DayCounterWidgetBundle: WidgetBundle {
    var body: some Widget {
        DayCounterWidget()
        DayCounterWidgetLiveActivity()
    }
}
