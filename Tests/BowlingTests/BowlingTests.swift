import XCTest
@testable import Bowling

final class BowlingTests: XCTestCase {
    // MARK: Phase 1
    func test_initialScore() throws {
        XCTAssertEqual(0, game.score)
    }
    
    func test_rolledOnce() throws {
        game.roll(3)
        XCTAssertEqual(3, game.score)
    }
    
    func test_rolledTwice() throws {
        game.roll(4)
        game.roll(2)
        XCTAssertEqual(6, game.score)
    }
    
    // MARK: Phase 2
    func test_isGameFinishedAfter20Rolls() throws {
        for _ in 1...20 {
            game.roll(0)
        }
        XCTAssertEqual(true, game.isFinish)
    }
    
    // MARK: Phase 3
    func test_doubleRollScoreAfterSpare() throws {
        doSpareRoll()
        game.roll(2)
        XCTAssertEqual(10 + 2*2, game.score)
    }
    
    // MARK: Phase 4
    func test_doubleNextTwoScoresAfterStrike() throws {
        doStrikeRoll()
        game.roll(4)
        game.roll(3)
        XCTAssertEqual(10 + 4*2 + 3*2, game.score)
    }
    
    func test_scoreAfterTripleStrikeAndTwoMissing() throws {
        doStrikeRoll()
        doStrikeRoll()
        doStrikeRoll()
        game.roll(0)
        game.roll(0)
        XCTAssertEqual(30 + 20 + 10, game.score)
    }
    
    // MARK: Phase 5
    
    func test_endGameWithMaxScore() throws {
        for _ in 1...12 {
            doStrikeRoll()
        }
        XCTAssertEqual(300, game.score)
        XCTAssertEqual(true, game.isFinish)
    }
    
    func test_additionalTurnAfterSpareInLastFrame() throws {
        for _ in 1...18 {
            game.roll(0)
        }
        doSpareRoll()
        game.roll(5)
        XCTAssertEqual(15, game.score)
        XCTAssertEqual(true, game.isFinish)
    }
    
    // MARK: Phase 6-7
    
    func test_whenAddTwoPlayers_shouldGetPlayersFromMonitor() throws {
        
        addPlayersGlebAndIgor()
        
        XCTAssertEqual(2, monitor.players.count)
    }
    
    func test_whenGameStart_FirstPlayerGetTurn() throws {
        
        addPlayersGlebAndIgor()
        
        XCTAssertEqual(0, monitor.playerTurnIndex)
    }
    
    func test_whenFirstPlayersFrameEnds_SecondPlayerShouldGetTurn() throws {
        addPlayersGlebAndIgor()
        
        monitor.roll(2)
        monitor.roll(2)
        
        XCTAssertEqual(1, monitor.playerTurnIndex)
    }
    
    
    // MARK: - Help
    func addPlayersGlebAndIgor() {
        monitor.addPlayer("Gleb")
        monitor.addPlayer("Igor")
    }
    
    func doSpareRoll() {
        game.roll(7)
        game.roll(3)
    }
    
    func doStrikeRoll() {
        game.roll(10)
    }
    
    // MARK: - Setup
    private var game: Game!
    private var monitor: Monitor!
    override func setUp() {
        game = Game()
        monitor = Monitor()
    }
    
    override func tearDown() {
        game = nil
        monitor = nil
    }
}
