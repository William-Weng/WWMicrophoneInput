//
//  Model.swift
//  WWMicrophoneInput
//
//  Created by William.Weng on 2026/8/18.
//

import AVFoundation

/// 音訊工作階段（AVAudioSession）的類別、模式與選項資訊
public struct WWCategoryInformation {
    
    public let category: AVAudioSession.Category
    public let mode: AVAudioSession.Mode
    public let options: AVAudioSession.CategoryOptions
    
    /// 建立 WWCategoryInformation 實體
    /// - Parameters:
    ///   - category: 音訊工作階段的類別
    ///   - mode: 音訊工作階段的模式
    ///   - options: 音訊工作階段的選項
    public init(category: AVAudioSession.Category, mode: AVAudioSession.Mode, options: AVAudioSession.CategoryOptions) {
        self.category = category
        self.mode = mode
        self.options = options
    }
}

/// 音訊工作階段是否處於啟用狀態的資訊
public struct WWActiveInformation {
    
    public let isActive: Bool
    public let options: AVAudioSession.SetActiveOptions
    
    /// 建立 WWActiveInformation 實體
    /// - Parameters:
    ///   - isActive: 是否啟用音訊工作階段
    ///   - options: 設定啟用狀態時的選項
    public init(isActive: Bool, options: AVAudioSession.SetActiveOptions) {
        self.isActive = isActive
        self.options = options
    }
}

/// 輕量級的音訊緩衝區包裝結構體，用於簡化音訊資料的存取與分析（例如計算音量）
public struct WWAudioPCMBuffer {
    
    public let value: AVAudioPCMBuffer
    
    /// 建立 WWAudioPCMBuffer 實體
    /// - Parameters:
    ///   - value: 是否啟用音訊工作階段
    ///   - options: 設定啟用狀態時的選項
    public init(value: AVAudioPCMBuffer) {
        self.value = value
    }
}

// MARK: - 公開屬性
public extension WWAudioPCMBuffer {
    
    /// 唯讀計算屬性：獲取目前音訊緩衝區的音幅（Amplitude，通常代表音量大小）
    /// - Returns: 傳回一個可空值的浮點數（Float?）。如果原生緩衝區無法計算或尚未實作該擴充功能，則傳回 nil
    public var amplitude: Float? {
        value.amplitude
    }
}
