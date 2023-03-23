import XCTest
@testable import Bowling

final class GameTests: XCTestCase {
    // MARK: - Setup
    private var sut: Game!
    override func setUp() {
        sut = Game()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: Phase 1
    func test_initialScore() {
        XCTAssertEqual(0, sut.score)
    }
    
    func test_rolledOnce() {
        
        roll(3)
        
        XCTAssertEqual(3, sut.score)
    }
    
    func test_rolledTwice() {
        roll(4)
        
        roll(2)
        
        XCTAssertEqual(6, sut.score)
    }
    
    // MARK: Phase 2
    func test_isGameFinishedAfter20Rolls() {
        
        roll(0, times: 20)
        
        XCTAssertTrue(sut.isFinish)
    }
    
    // MARK: Phase 3
    func test_doubleRollScoreAfterSpare() {
        spare()
        
        roll(2)
        
        XCTAssertEqual(10 + 2*2, sut.score)
    }
    
    // MARK: Phase 4
    func test_doubleNextTwoScoresAfterStrike() {
        strike()
        
        roll(4)
        roll(3)
        
        XCTAssertEqual(10 + 4*2 + 3*2, sut.score)
    }
    
    func test_scoreAfterTripleStrikeAndTwoMissing() {
        
        roll(.strike, times: 3)
        
        XCTAssertEqual(30 + 20 + 10, sut.score)
    }
    
    // MARK: Phase 5
    
    func test_endGameWithMaxScore() {
        
        roll(.strike, times: 12)
        
        XCTAssertEqual(300, sut.score)
        XCTAssertTrue(sut.isFinish)
    }
    
    func test_additionalTurnAfterSpareInLastFrame() {
        roll(0, times: 18)
        
        spare()
        roll(5)
        
        XCTAssertEqual(15, sut.score)
        XCTAssertTrue(sut.isFinish)
    }
    
    
    // MARK: - DSL
    
    func spare(_ firstRoll: Int = 7) {
        roll(firstRoll)
        roll(10 - firstRoll)
    }
    
    func strike() {
        roll(10)
    }
    
    func roll(_ score: Int) {
        sut.roll(score)
    }
    
    func roll(_ score: Int, times: Int) {
        for _ in 1...times {
            roll(score)
        }
    }
}

fileprivate extension Int {
    static var strike: Self = 10
}
