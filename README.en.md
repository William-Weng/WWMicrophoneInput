[English](./README.en.md) | [正體中文](./README.md)

# [WWMicrophoneInput](https://swiftpackageindex.com/William-Weng)

[![Swift-5.10](https://img.shields.io/badge/Swift-5.10-orange.svg)](https://developer.apple.com/swift/)
[![iOS-17.0](https://img.shields.io/badge/iOS-17.0-pink.svg?style=flat)](https://developer.apple.com/swift/)
![TAG](https://img.shields.io/github/v/tag/William-Weng/WWMicrophoneInput)
![SPM](https://img.shields.io/badge/SPM-supported-brightgreen.svg)
[![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

A lightweight iOS microphone input manager built on `AVAudioEngine`, providing a simple and easy-to-use API for capturing PCM audio data from the microphone.

## ✨ Features

- **Real-time Microphone Input**: Captures high-quality PCM audio buffers via `AVAudioEngine`
- **Flexible Audio Session Configuration**: Supports custom `AVAudioSession` category, mode, and options
- **Asynchronous Callback Mechanism**: Receives audio data in real-time through `@Sendable` callback functions
- **Type-safe Error Handling**: Uses `WWMicrophoneInputError` to provide clear error information
- **Easy Integration**: Clean design that can be easily integrated into speech recognition, audio processing, and other application scenarios

## 📦 Installation

### Using Swift Package Manager

In Xcode, select:

`File` → `Add Package Dependencies...`

Then enter the package repository URL, select the version to use, and add the package to your App target.

If this is a local package, you can also use in Xcode:

`File` → `Add Package Dependencies...` → `Add Local...`

## 🏗️ Public API

| API | Description |
| --- | --- |
| `requestAuthorization()` | Requests microphone recording permission. |
| `init(bufferHandler:)` | Creates a WWMicrophoneInput instance. |
| `configure(category:active:)` | Configures the audio session (AVAudioSession) category, mode, and options, and sets whether to activate it. |
| `start(level:)` | Starts microphone input. |
| `stop()` | Stops microphone input. |

## 📌 Public Properties

| Name | Description |
| --- | --- |
| `isRunning` | Indicates whether recording is in progress. |

## 🧪 [Simple Example](https://github.com/William-Weng/RealTimeSpeechToText)

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
            transcription?.append(buffer: buffer.value)
        }
        
        try microphone.configure()
        try transcription.start()
        try microphone.start()
        
        self.transcription = transcription
        self.microphoneInput = microphone
    }
}
```
