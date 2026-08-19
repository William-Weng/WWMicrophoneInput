[English](./README.en.md) | [正體中文](./README.md)

# [WWMicrophoneInput](https://swiftpackageindex.com/William-Weng)

[![Swift-5.10](https://img.shields.io/badge/Swift-5.10-orange.svg)](https://developer.apple.com/swift/)
[![iOS-17.0](https://img.shields.io/badge/iOS-17.0-pink.svg?style=flat)](https://developer.apple.com/swift/)
![TAG](https://img.shields.io/github/v/tag/William-Weng/WWMicrophoneInput)
![SPM](https://img.shields.io/badge/SPM-supported-brightgreen.svg)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

一個輕量級的 iOS 麥克風輸入管理器，基於 `AVAudioEngine` 實現，提供簡單易用的 API 來捕捉麥克風的 PCM 音訊數據。

## ✨ 功能特色

- **即時麥克風輸入**：透過 `AVAudioEngine` 捕捉高品質的 PCM 音訊緩衝區
- **靈活的音訊會話配置**：支援自訂 `AVAudioSession` 的 category、mode 與 options
- **非同步回呼機制**：透過 `@Sendable` 回呼函數即時接收音訊數據
- **型別安全的錯誤處理**：使用 `WWMicrophoneInputError` 提供明確的錯誤資訊
- **易於整合**：設計簡潔，可輕鬆整合到語音識別、音訊處理等應用場景

## 📦 安裝方式

### 使用 Swift Package Manager

在 Xcode 中選擇：

`File` → `Add Package Dependencies...`

接著輸入套件 repository URL，選擇要使用的版本，並將套件加入 App target。

如果這是本地套件，也可以在 Xcode 中使用：

`File` → `Add Package Dependencies...` → `Add Local...`

## 🏗️ 公開 API

| API | 說明 |
| --- | --- |
| `init(bufferHandler:)` | 建立 WWMicrophoneInput 實體。 |
| `configure(category:active:)` | 設定音訊工作階段（AVAudioSession）的類別、模式與選項，並設定是否啟用。 |
| `start(level:)` | 啟動麥克風輸入。 |
| `stop()` | 停止麥克風輸入。 |

## 📌 公開屬性

| 名稱 | 說明 |
| --- | --- |
| `isRunning` | 是否正在錄音中。 |

## 🧪 [簡單範例](https://github.com/William-Weng/RealTimeSpeechToText)

```swift
private extension SpeechViewModel {
    
    func createAudioPipeline() throws {
        
        let transcription = try WWAudioStreamTranscription(locale: locale)
        
        transcription.onResult = { [weak self] text, isFinal in
            
            Task { @MainActor in
                self?.text = text
                if isFinal { self?.isRecording = false }
            }
        }
        
        transcription.onError = { [weak self] error in
            
            Task { @MainActor in
                self?.errorMessage = error.localizedDescription
                self?.stop()
            }
        }
        
        let microphone = WWMicrophoneInput { [weak transcription] buffer in
            transcription?.append(buffer: buffer)
        }
        
        try microphone.configure()
        try transcription.start()
        try microphone.start()
        
        self.transcription = transcription
        self.microphoneInput = microphone
    }
}
```
