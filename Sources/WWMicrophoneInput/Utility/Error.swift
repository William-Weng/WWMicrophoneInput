//
//  Model.swift
//  WWMicrophoneInput
//
//  Created by William.Weng on 2026/8/18.
//

import Foundation

/// 音訊工作階段發生的錯誤
public enum WWMicrophoneInputError: LocalizedError {
    
    case isRunning              // 錄音裝置已經在運行中
    case invalidAudioFormat     // 無法取得有效的音訊格式
    case system(error: Error)   // 發生系統錯誤
    
    public var errorDescription: String? {
        switch self {
        case .isRunning: "The recording device is already running."
        case .invalidAudioFormat: "Unable to obtain a valid audio format."
        case .system(let error): "A system-level error occurred: \(error)"
        }
    }
}
