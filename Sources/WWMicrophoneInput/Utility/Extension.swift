//
//  Extension.swift
//  WWMicrophoneInput
//
//  Created by William.Weng on 2026/8/19.
//

import AVFAudio
import Accelerate

// MARK: - AVAudioPCMBuffer
extension AVAudioPCMBuffer {
    
    /// [使用 Accelerate 框架計算振幅（RMS - Root Mean Square）](https://www.forasoft.com/blog/article/how-to-implement-silence-trimming-feature-to-your-ios-app-1720)
    ///
    /// - Returns: RMS 振幅值
    var amplitude: Float? {
        
        guard let audioData = floatChannelData?[0] else { return nil }
        
        let frameCount = Int(frameLength)
        var sum: Float = 0
        
        vDSP_svesq(audioData, 1, &sum, UInt(frameCount))
        
        let mean = sum / Float(frameCount)
        return sqrtf(mean)
    }
}
