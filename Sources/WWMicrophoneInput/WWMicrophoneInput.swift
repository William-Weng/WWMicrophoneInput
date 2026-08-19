//
//  WWMicrophoneInput.swift
//  WWMicrophoneInput
//
//  Created by William.Weng on 2026/8/18.
//

import AVFoundation

/// 麥克風輸入管理器
///
/// 負責設定 AVAudioSession、啟動/停止 AVAudioEngine，並將 PCM buffer 回傳給呼叫端
public final class WWMicrophoneInput {
    
    public private(set) var isRunning = false   // 是否正在錄音中
    
    private let audioEngine = AVAudioEngine()   // 底層使用的音訊引擎
    
    private let bufferHandler: @Sendable (AVAudioPCMBuffer) -> Void
    
    /// 建立 WWMicrophoneInput 實體
    ///
    /// - Parameter bufferHandler: 當有新的 PCM buffer 可用時呼叫的回呼
    public init(bufferHandler: @escaping @Sendable (AVAudioPCMBuffer) -> Void) {
        self.bufferHandler = bufferHandler
    }
}

// MARK: - Public API
public extension WWMicrophoneInput {
    
    /// 設定音訊工作階段（AVAudioSession）的類別、模式與選項，並設定是否啟用
    /// - Parameters:
    ///   - categoryInfo: 音訊工作階段的類別、模式與選項資訊
    ///   - activeInfo: 是否啟用音訊工作階段，以及啟用時的選項
    /// - Throws: 若設定失敗則拋出錯誤
    func configure(category categoryInfo: WWCategoryInformation = .init(category: .record, mode: .measurement, options: [.duckOthers]), active activeInfo : WWActiveInformation = .init(isActive: true, options: .notifyOthersOnDeactivation)) throws {
        
        let session = AVAudioSession.sharedInstance()
        
        try session.setCategory(categoryInfo.category, mode: categoryInfo.mode, options: categoryInfo.options)
        try session.setActive(activeInfo.isActive, options: activeInfo.options)
    }
    
    /// 啟動麥克風輸入
    ///
    /// - Throws: 若啟動失敗則拋出錯誤
    func start() throws {
        if let error = start() { throw error }
    }
    
    /// 停止麥克風輸入
    ///
    /// - Throws: 若停止失敗則拋出錯誤
    func stop() throws {
        if let error = stop() { throw error }
    }
}

// MARK: - Private Implementation
private extension WWMicrophoneInput {
    
    /// 內部啟動邏輯
    ///
    /// 啟動 AVAudioEngine 並安裝麥克風輸入的 Tap，開始接收音訊資料
    ///
    /// - Parameter level: 緩衝區大小等級，預設為中等延遲（1024 frames）
    /// - Returns: 若發生錯誤則回傳對應的 WWMicrophoneInputError，否則回傳 nil
    func start(level: BufferFrameSizeLevel = .middle) -> WWMicrophoneInputError? {
        
        guard !isRunning else { return .isRunning }
        
        let inputNode = audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        
        guard format.sampleRate > 0, format.channelCount > 0 else { return .invalidAudioFormat }
        
        inputNode.removeTap(onBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: level.value, format: format) { [bufferHandler] buffer, _ in
            bufferHandler(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
            isRunning = true
        } catch {
            return .system(error: error)
        }
        
        return nil
    }
    
    /// 內部停止邏輯
    /// 
    /// - Returns: 若發生錯誤則回傳對應的 WWMicrophoneInputError，否則回傳 nil
    func stop() -> WWMicrophoneInputError? {
        
        guard isRunning else { return .isRunning }
        
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        
        isRunning = false
        
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            return .system(error: error)
        }
        
        return nil
    }
}
