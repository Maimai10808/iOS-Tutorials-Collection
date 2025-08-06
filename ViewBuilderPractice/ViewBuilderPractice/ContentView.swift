//
//  ContentView.swift
//  ViewBuilderPractice
//
//  Created by mac on 8/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var excercises = [
        Exercise(name: "Bench Press", reps: 10, weight: 80),
        Exercise(name: "Squat", reps: 12, weight: 100),
        Exercise(name: "Deadlift", reps: 8, weight: 120),
        Exercise(name: "Overhead Press", reps: 10, weight: 45),
        Exercise(name: "Barbell Row", reps: 10, weight: 60),
        Exercise(name: "Pull-ups", reps: 15, weight: 0),
        Exercise(name: "Dumbbell Curl", reps: 12, weight: 15)
    ]
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("Workout Summary")
                .font(.title)
            
            Text("Text")
                .capsuleTextStyle()
            
            WorkoutGrid {
                Text("Name")
                    .font(.system(size: 15, weight: .semibold))
                Text("Reps")
                    .font(.system(size: 15, weight: .semibold))
                Text("Kgs")
                    .font(.system(size: 15, weight: .semibold))
                
                ForEach(excercises) { excercise in
                    Text(excercise.name)
                    Text("\(excercise.reps)")
                    Text("\(excercise.weight)")
                }
                
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    ContentView()
}
