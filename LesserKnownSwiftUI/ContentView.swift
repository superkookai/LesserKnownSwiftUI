//
//  ContentView.swift
//  LesserKnownSwiftUI
//
//  Created by Weerawut on 3/3/2569 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color(red: 1, green: 0, blue: 0))
                .frame(width: 300, height: 300)
                .offset(x: 0, y: 100)
            
            Circle()
                .fill(Color(red: 0, green: 1, blue: 0))
                .frame(width: 300, height: 300)
                .offset(x: 100, y: -100)
            
            Circle()
                .fill(Color(red: 0, green: 0, blue: 1))
                .frame(width: 300, height: 300)
                .offset(x: -100, y: -100)
        }
        .compositingGroup()
//        .drawingGroup()
//        .clipped()
        .opacity(0.25)
    }
}

#Preview {
    ContentView()
}


//Text("Hello World")
//    .font(.largeTitle)
//    .foregroundStyle(.white)
//    .padding()
//    .background(Color.blue)
//    .compositingGroup()
//    .shadow(color: .black, radius: 5)


//forcing SwiftUI to do an off-screen render pass because that’s how the clipped() modifier works.

//Off-screen rendered views = these were drawn off-screen, then the final result was drawn back into our layout.

//compositingGroup() modifier comes in: it applies any rendering effects before continuing down the modifier chain, effectively flattening your drawing so that any later effects apply to the whole object rather than its individual components.

//Drawing groups also render views off-screen before placing the result back into your view, but they have one key difference: they use Metal. This has the major advantage of delivering extremely high performance when you’re doing complicated drawing effects – some things that are crushingly slow in regular SwiftUI views run at 120fps using drawing groups.

/*However, it also creates two downsides:
 
 Metal can’t render native platform views, like text views and toggle switches. As a result, inside drawing groups they get replaced with an error image.
 Metal renders its work using the original bounds of the view it was drawing, as if clipped() had been applied first.
 */

//As a result, if you replace compositingGroup() with drawingGroup() here you’ll see the result is very different: one grouped opacity, yes, but it will also clip our circles into a square container. That is enough space to hold our 300x300 circles, but their offset positions are ignored – they are being ignored, but that wider frame isn’t being taken into account.

/*So, compositing groups solve a very specific but important problem:
 
 They group rendered views together so that subsequent modifiers apply to the whole group rather than individual views.
 They don’t clip the contents of the view, so your layout won’t change.
 They also don’t push work out to Metal, so they be used with platform views.
 Broadly speaking, compositingGroup() is a much better choice than drawingGroup() – only use the latter if you specifically need that Metal acceleration!
 */
