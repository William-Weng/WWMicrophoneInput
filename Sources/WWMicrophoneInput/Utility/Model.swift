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
