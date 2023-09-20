//
//  Source.swift
//  WCVideoEditor
//
//  Created by Wc on 2023/8/17.
//

#if DEBUG
    func debugFatalError(_ message: String, file: StaticString = #file, line: UInt = #line) -> Never {
        fatalError(message, file: file, line: line)
    }
#else
    func debugFatalError(_ message: String, file: StaticString = #file, line: UInt = #line) -> Never {
        print(message, file: file, line: line)
        exit(0)
    }
#endif

import AVFoundation

public protocol Source {
    var selectedTimeRange: CMTimeRange { get set }
    var duration: CMTime { get set }
    
    func tracks(for type: AVMediaType) -> [AVAssetTrack]
}
