//
//  StatisticView.swift
//  openInApp

import SwiftUI

struct StatisticView: View {
    let icon: String
    let count: String
    let label: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.blue)
            Text(count)
                .font(.title)
                .bold()
            Text(label)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }
}
