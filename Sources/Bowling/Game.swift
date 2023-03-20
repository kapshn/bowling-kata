final public class Game {
    
    public var score: Int {
        var score = 0
        for (index, frame) in frames.enumerated() {
            if frame.isLastFrame {
                score += frame.score
            } else {
                switch frame.state {
                case .strike:
                    if index == 8 {
                        score += (frames[safe: 9]?.firstRoll ?? 0) + (frames[safe: 9]?.secondRoll ?? 0)
                    } else {
                        if frames[safe: index + 1]?.state == .strike {
                            score += 10 + (frames[safe: index + 2]?.firstRoll ?? 0)
                        } else {
                            score += (frames[safe: index + 1]?.score ?? 0)
                        }
                    }
                    score += 10
                case .spare:
                    score += 10 + (frames[safe: index + 1]?.firstRoll ?? 0)
                default:
                    score += frame.score
                }
            }
        }
        return score
    }
    
    public var isFinish: Bool {
        if frames.count == 10, let frame = frames.last, frame.state == .finishedFrame {
            return true
        }
        return false
    }
    
    public var isFrameFinished: Bool {
        switch frames.last?.state {
        case .unfinishedFrame: return false
        case .strike, .spare, .finishedFrame: return true
        default: return false
        }
    }
    
    public var frameCount: Int {
        frames.count
    }
    
    private var frames: [Frame]

    public init() {
        frames = []
    }
    
    func roll(_ rolledScore: Int) {
        if frames.isEmpty {
            newFrame(rolledScore)
        } else if let frame = frames.last {
            switch frame.state {
            case .unfinishedFrame:
                frame.setNextRoll(rolledScore)
            default:
                newFrame(rolledScore, frames.count == 9)
            }
        }
    }
    
    private func newFrame(_ rolledScore: Int, _ isLastFrame: Bool = false) {
        let frame = Frame(firstRoll: rolledScore,
                          isLastFrame: isLastFrame)
        frames.append(frame)
    }
}

fileprivate extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
