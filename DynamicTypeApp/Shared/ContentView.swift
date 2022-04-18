//
//  ContentView.swift
//  Shared
//
//  Created by Keigo Nakagawa on 2022/04/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .font(.largeTitle)
                .dynamicTypeSize(DynamicTypeSize.medium...DynamicTypeSize.large)
                .padding()

            Text("test hoge hoge!")
                .font(.caption)
                .dynamicTypeSize(...DynamicTypeSize.large)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .dynamicTypeSize(.medium)
    }
}
