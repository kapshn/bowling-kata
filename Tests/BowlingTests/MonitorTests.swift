import XCTest
@testable import Bowling

final class MonitorTests: XCTestCase {
    // MARK: - Setup
    private var sut: Monitor!
    override func setUp() {
        sut = Monitor()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    // MARK: Phase 6-7
    
    func test_whenAddTwoPlayers_shouldGetPlayersFromMonitor() {
        
        addPlayersGlebAndIgor()
        
        XCTAssertEqual(2, sut.players.count)
    }
    
    func test_whenGameStart_FirstPlayerGetTurn() {
        
        addPlayersGlebAndIgor()
        
        XCTAssertEqual(0, sut.playerTurnIndex)
    }
    
    func test_whenFirstPlayersFrameEnds_SecondPlayerShouldGetTurn() {
        addPlayersGlebAndIgor()
    
        sut.roll(2)
        sut.roll(2)
        
        XCTAssertEqual(1, sut.playerTurnIndex)
    }
    
    
    // MARK: - DSL
    func addPlayersGlebAndIgor() {
        sut.addPlayer("Gleb")
        sut.addPlayer("Igor")
    }
    
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
