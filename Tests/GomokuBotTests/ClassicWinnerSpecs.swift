//
//  ClassicWinnerSpecs.swift
//  Gomoku
//
//  Created by Robert on 19/03/2023.
//

import Quick
import Nimble
@testable import GomokuBot

class ClassicWinnerSpecs: QuickSpec {
    override func spec() {
        rowSpecs()
    }
    
    func rowSpecs() {
        describe("Test a grid with only one row") {
            var winnerTester: WinnerTestable!
            
            beforeEach {
                winnerTester = ClassicWinnerTester()
            }
            
            context("that row contains exact 5 of 1s") {
                it("testResult equals 1") {
                    let row: ContiguousArray<Int> = [1, 1, 1, 1, 1]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == 1
                }
            }
            
            context("that row contains more than 5 of 1s") {
                it("testResult equals 1") {
                    let row: ContiguousArray<Int> = [1, 1, 1, 1, 1, 1]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == 1
                }
            }
            
            context("that row contains exact 5 of 1s and 1 leading 0") {
                it("testResult equals 1") {
                    let row: ContiguousArray<Int> = [0, 1, 1, 1, 1, 1]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == 1
                }
            }
            
            context("that row contains exact 5 of 1s and 1 trailing 0") {
                it("testResult equals 1") {
                    let row: ContiguousArray<Int> = [1, 1, 1, 1, 1, 0]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == 1
                }
            }
            
            context("that row contains exact 5 of 1s, 1 leading 0 and 1 trailing 0") {
                it("testResult equals 1") {
                    let row: ContiguousArray<Int> = [0, 1, 1, 1, 1, 1, 0]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == 1
                }
            }
            
            context("that row contains exact 5 of 1s and 1 of 0 interspersing among 1s") {
                it("testResult equals 1") {
                    let row: ContiguousArray<Int> = [1, 1, 1, 0, 1, 1]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)).to(beNil())
                }
            }
            
            context("that row contains exact 5 of 1s and 1 leading 2") {
                it("testResult equals 1") {
                    let row: ContiguousArray<Int> = [2, 1, 1, 1, 1, 1]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == 1
                }
            }
            
            context("that row contains exact 5 of 1s and 1 trailing 2") {
                it("testResult equals 1") {
                    let row: ContiguousArray<Int> = [1, 1, 1, 1, 1, 2]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == 1
                }
            }
            
            context("that row contains exact 5 of 1s, 1 leading 2 and 1 trailing 2") {
                it("testResult equals 1") {
                    let row: ContiguousArray<Int> = [2, 1, 1, 1, 1, 1, 2]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == 1
                }
            }
            
            context("that row contains exact 5 of 1s and 1 of 2 interspersing among 1s") {
                it("testResult equals 1") {
                    let row: ContiguousArray<Int> = [1, 1, 1, 2, 1, 1]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)).to(beNil())
                }
            }
            
            context("that row contains exact 5 of 1s, 1 leading 0 and 1 trailing 2") {
                it("testResult equals 1") {
                    let row: ContiguousArray<Int> = [0, 1, 1, 1, 1, 1, 2]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == 1
                }
            }
            
            context("that row contains exact 5 of 1s, 1 leading 2 and 1 trailing 0") {
                it("testResult equals 1") {
                    let row: ContiguousArray<Int> = [2, 1, 1, 1, 1, 1, 0]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == 1
                }
            }
        }
    }
}
