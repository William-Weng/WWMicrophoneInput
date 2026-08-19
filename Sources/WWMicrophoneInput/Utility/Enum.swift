//
//  Enum.swift
//  WWMicrophoneInput
//
//  Created by William.Weng on 2026/8/19.
//

import Foundation

/// 音訊緩衝區大小等級
public enum BufferFrameSizeLevel {
    
    case low                    // 低延遲（適合即時音訊處理、音訊視覺化）
    case middle                 // 中等（適合語音辨識、一般錄音）
    case high                   // 高吞吐（適合離線處理、批量錄音）
}

// MARK: - 公開屬性
public extension BufferFrameSizeLevel {
    
    /// 取得對應的 frame 數量
    var value: UInt32 {
        switch self {
        case .low: 256          // ~5.8ms @ 44.1kHz
        case .middle: 1_024     // ~23.2ms
        case .high: 4_096       // ~92.9ms
        }
    }
    
    /// 對應的延遲時間（毫秒）@ 44.1kHz
    var latencyMs: Double {
        Double(value) / 44_100.0 * 1_000.0
    }
}
