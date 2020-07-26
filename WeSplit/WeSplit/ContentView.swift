//
//  ContentView.swift
//  WeSplit
//
//  Created by DHK on 2020/07/26.
//  Copyright © 2020 DHK. All rights reserved.
//
//  Initial user interface for program
//  (This is where we'll be doing all the work!)

import SwiftUI

struct ContentView: View {
    // The view protocol has one req => there must be a bocy that returns some view
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 18, 20, 25, 0]
    
    var checkDouble: Double {
        return Double(checkAmount) ?? 0
    }
    
    var tipAmount: Double {
        return Double(tipPercentages[tipPercentage])/100 * checkDouble
    }
    
    var totalAmount: Double {
        return tipAmount + checkDouble
    }
    
    var totalPerPerson: Double {
        return totalAmount/Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                    .keyboardType(.decimalPad)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(0 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section (header: Text("How much tip would you like to leave?")) {
                    Picker("Tip Percentages", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section {
                    Text("Check: $\(checkDouble, specifier: "%.2f")")
                    Text("Tip: $\(tipAmount, specifier: "%.2f")")
                    Text("Total: $\(totalAmount, specifier: "%.2f")")
                    Text("Per Person: $\(totalPerPerson, specifier: "%.2f")")
                }
                
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    // This is only for Xcode to use so it can show a preview of the UI design
    static var previews: some View {
        ContentView()
    }
}
