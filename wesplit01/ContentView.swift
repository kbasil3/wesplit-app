//
//  ContentView.swift
//  wesplit01
//
//  Created by Katie on 4/4/24.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 1 // Default to 10%
    
    let tipPercentages = 0..<101
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipValue = checkAmount / 100 * Double(tipPercentages[tipPercentage])
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
       

        return amountPerPerson
    }
    
    var totalAmount : Double{
        let peopleCount = Double(numberOfPeople + 2)
               let tipValue = checkAmount / 100 * Double(tipPercentages[tipPercentage])
               let grandTotal = checkAmount + tipValue
               let amountPerPerson = grandTotal / peopleCount
               let Total = Double(amountPerPerson * peopleCount)
               return checkAmount + Total
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, formatter: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(NavigationLinkPickerStyle())
                }
                
                Section(header: Text("Number of people")) {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("Amount per person")) {
                    Text("\(totalPerPerson, specifier: "%.2f")")
              
                }
                Section(header: Text("Total for check")) {
                    Text("\(totalAmount, specifier: "%.2f")")
                }
            }
        
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
                
            }
        }
    }
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currency?.identifier ?? "USD"
        return formatter
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
