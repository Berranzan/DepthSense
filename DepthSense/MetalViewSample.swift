/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A parent view class that displays the sample app's other views.
*/

import Foundation
import SwiftUI
import MetalKit
import ARKit


struct MetalDepthView: View {
    
    
    var arProvider: ARProvider = ARProvider()
    let ciContext: CIContext = CIContext()
    @State var selectedConfidence = 0
    @State var depthValue = 1.0
    @State var myUnit = ToneOutputUnit()
    @State var spekersActive = true
    @State var scaningFreq: Double = (1/10)
    @State var timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    
    var body: some View {
        if spekersActive{
            let _ = myUnit.enableSpeaker()
            let _ = myUnit.setToneTime(t: scaningFreq)
            let _ = myUnit.setFrequency(freq: Double(3300.0 - 2450.0 * depthValue))
        }
        ZStack{
            if !ARWorldTrackingConfiguration.supportsFrameSemantics([.sceneDepth, .smoothedSceneDepth]) {
                Text("Unsupported Device: This app requires the LiDAR Scanner to access the scene's depth.")
            } else {
                MetalTextureViewDepth(content: arProvider.depthContent, confSelection: $selectedConfidence)
                    .edgesIgnoringSafeArea(.all)
                //.grayscale(Double(1.0))
                    .onAppear {
                        timer.upstream.connect().cancel()
                        timer = Timer.publish(every: scaningFreq, on: .main, in: .common).autoconnect()
                        var _ = UIApplication.shared.isIdleTimerDisabled = true
                    }.onReceive(timer) { _ in
                        depthValue = Double(arProvider.GetColor()!)
                        
                    }.onTapGesture {
                        myUnit.avActive.toggle()
                        spekersActive.toggle()
                    }
                    .onDisappear{
                        var _ = UIApplication.shared.isIdleTimerDisabled = false
                    }
                
            }
            
            Image(systemName: "circle")
        }
    }
}
    
