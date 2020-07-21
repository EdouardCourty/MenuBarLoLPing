//
//  ContentView.swift
//  MenuBarPing
//
//  Created by Edouard Courty on 21/07/2020.
//  Copyright © 2020 Edouard Courty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(AppDelegate.HOST)
            .frame(width: 200, height: 100)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
