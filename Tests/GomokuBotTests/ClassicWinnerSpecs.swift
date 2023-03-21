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
        columnSpecs()
        primaryDiagonalSpecs()
        secondaryDiagonalSpecs()
    }
    
    func rowSpecs() {
        describe("Test a grid with only one row") {
            var winnerTester: WinnerTestable!
            
            beforeEach {
                winnerTester = ClassicWinnerTester()
            }
            
            context("that row contains exact 4 of 1s and 1 leading 0") {
                it("testResult equals nil") {
                    let row: ContiguousArray<Int> = [0, 1, 1, 1, 1]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == nil
                }
            }
            
            context("that row contains exact 4 of 1s and 1 trailing 0") {
                it("testResult equals nil") {
                    let row: ContiguousArray<Int> = [1, 1, 1, 1, 0]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == nil
                }
            }
            
            context("that row contains exact 4 of 1s and 1 leading 2") {
                it("testResult equals nil") {
                    let row: ContiguousArray<Int> = [2, 1, 1, 1, 1]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == nil
                }
            }
            
            context("that row contains exact 4 of 1s and 1 trailing 2") {
                it("testResult equals nil") {
                    let row: ContiguousArray<Int> = [1, 1, 1, 1, 2]
                    let grid: BoardGrid = [row]
                    expect(winnerTester.testRow(at: 0, grid: grid)) == nil
                }
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
                it("testResult equals nil") {
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
                it("testResult equals nil") {
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
    
    func columnSpecs() {
        describe("Test a grid with only one column") {
            var winnerTester: WinnerTestable!
            
            beforeEach {
                winnerTester = ClassicWinnerTester()
            }
            
            context("that column contains exact 4 of 1s and 1 leading 0") {
                it("testResult equals nil") {
                    let grid: BoardGrid = [[0], [1], [1], [1], [1]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == nil
                }
            }
            
            context("that column contains exact 4 of 1s and 1 trailing 0") {
                it("testResult equals nil") {
                    let grid: BoardGrid = [[1], [1], [1], [1], [0]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == nil
                }
            }
            
            context("that column contains exact 4 of 1s and 1 leading 2") {
                it("testResult equals nil") {
                    let grid: BoardGrid = [[2], [1], [1], [1], [1]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == nil
                }
            }
            
            context("that column contains exact 4 of 1s and 1 trailing 2") {
                it("testResult equals nil") {
                    let grid: BoardGrid = [[1], [1], [1], [1], [2]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == nil
                }
            }
            
            context("that column contains exact 5 of 1s") {
                it("testResult equals 1") {
                    let grid: BoardGrid = [[1], [1], [1], [1], [1]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == 1
                }
            }
            
            context("that column contains more than 5 of 1s") {
                it("testResult equals 1") {
                    let grid: BoardGrid = [[1], [1], [1], [1], [1], [1]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == 1
                }
            }
            
            context("that column contains exact 5 of 1s and 1 leading 0") {
                it("testResult equals 1") {
                    let grid: BoardGrid = [[0], [1], [1], [1], [1], [1]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == 1
                }
            }
            
            context("that column contains exact 5 of 1s and 1 trailing 0") {
                it("testResult equals 1") {
                    let grid: BoardGrid = [[1], [1], [1], [1], [1], [0]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == 1
                }
            }
            
            context("that column contains exact 5 of 1s, 1 leading 0 and 1 trailing 0") {
                it("testResult equals 1") {
                    let grid: BoardGrid = [[0], [1], [1], [1], [1], [1], [0]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == 1
                }
            }
            
            context("that column contains exact 5 of 1s and 1 of 0 interspersing among 1s") {
                it("testResult equals nil") {
                    let grid: BoardGrid = [[1], [1], [1], [0], [1], [1]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)).to(beNil())
                }
            }
            
            context("that column contains exact 5 of 1s and 1 leading 2") {
                it("testResult equals 1") {
                    let grid: BoardGrid = [[2], [1], [1], [1], [1], [1]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == 1
                }
            }
            
            context("that column contains exact 5 of 1s and 1 trailing 2") {
                it("testResult equals 1") {
                    let grid: BoardGrid = [[1], [1], [1], [1], [1], [2]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == 1
                }
            }
            
            context("that column contains exact 5 of 1s, 1 leading 2 and 1 trailing 2") {
                it("testResult equals 1") {
                    let grid: BoardGrid = [[2], [1], [1], [1], [1], [1], [2]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == 1
                }
            }
            
            context("that column contains exact 5 of 1s and 1 of 2 interspersing among 1s") {
                it("testResult equals nil") {
                    let grid: BoardGrid = [[1], [1], [1], [2], [1], [1]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)).to(beNil())
                }
            }
            
            context("that column contains exact 5 of 1s, 1 leading 0 and 1 trailing 2") {
                it("testResult equals 1") {
                    let grid: BoardGrid = [[0], [1], [1], [1], [1], [1], [2]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == 1
                }
            }
            
            context("that column contains exact 5 of 1s, 1 leading 2 and 1 trailing 0") {
                it("testResult equals 1") {
                    let grid: BoardGrid = [[2], [1], [1], [1], [1], [1], [0]]
                    expect(winnerTester.testColumn(at: 0, grid: grid)) == 1
                }
            }
        }
    }
    
    func primaryDiagonalSpecs() {
        describe("Test a primary diagonal of a squared grid") {
            var winnerTester: WinnerTestable!
            
            beforeEach {
                winnerTester = ClassicWinnerTester()
            }
            
            context("the grid is a 5x5 matrix") {
                context("that primary diagonal contains exact 4 of 1s and 1 leading 0") {
                    it("testResult equals nil") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0],
                            [0, 0, 1, 0, 0],
                            [0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 1],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == nil
                    }
                }
                
                context("that primary diagonal contains exact 4 of 1s and 1 trailing 0") {
                    it("testResult equals nil") {
                        let grid: BoardGrid = [
                            [1, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0],
                            [0, 0, 1, 0, 0],
                            [0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == nil
                    }
                }
                
                context("that primary diagonal contains exact 4 of 1s and 1 leading 2") {
                    it("testResult equals nil") {
                        let grid: BoardGrid = [
                            [2, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0],
                            [0, 0, 1, 0, 0],
                            [0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 1],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == nil
                    }
                }
                
                context("that primary diagonal contains exact 4 of 1s and 1 trailing 2") {
                    it("testResult equals nil") {
                        let grid: BoardGrid = [
                            [1, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0],
                            [0, 0, 1, 0, 0],
                            [0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 2],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == nil
                    }
                }
                
                context("that primary diagonal contains exact 5 of 1s") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [1, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0],
                            [0, 0, 1, 0, 0],
                            [0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 1],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
            }
            
            context("the grid is a 6x6 matrix") {
                context("that primary diagonal contains more than 5 of 1s") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [1, 0, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [0, 0, 1, 0, 0, 0],
                            [0, 0, 0, 1, 0, 0],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 0, 1],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
                
                context("that primary diagonal contains exact 5 of 1s and 1 leading 0") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [0, 0, 1, 0, 0, 0],
                            [0, 0, 0, 1, 0, 0],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 0, 1],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
                
                context("that primary diagonal contains exact 5 of 1s and 1 trailing 0") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [1, 0, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [0, 0, 1, 0, 0, 0],
                            [0, 0, 0, 1, 0, 0],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
                
                context("that primary diagonal contains exact 5 of 1s and 1 of 0 interspersing among 1s") {
                    it("testResult equals nil") {
                        let grid: BoardGrid = [
                            [1, 0, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [0, 0, 0, 0, 0, 0],
                            [0, 0, 0, 1, 0, 0],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 0, 1],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == nil
                    }
                }
                
                context("that primary diagonal contains exact 5 of 1s and 1 leading 2") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [2, 0, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [0, 0, 1, 0, 0, 0],
                            [0, 0, 0, 1, 0, 0],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 0, 1],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
                
                context("that primary diagonal contains exact 5 of 1s and 1 trailing 2") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [1, 0, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [0, 0, 1, 0, 0, 0],
                            [0, 0, 0, 1, 0, 0],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 0, 2],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
                
                context("that primary diagonal contains exact 5 of 1s and 1 of 2 interspersing among 1s") {
                    it("testResult equals nil") {
                        let grid: BoardGrid = [
                            [1, 0, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [0, 0, 2, 0, 0, 0],
                            [0, 0, 0, 1, 0, 0],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 0, 1],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == nil
                    }
                }
            }
            
            context("the grid is a 7x7 matrix") {
                context("that primary diagonal contains exact 5 of 1s, 1 leading 0 and 1 trailing 0") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0, 0],
                            [0, 0, 1, 0, 0, 0, 0],
                            [0, 0, 0, 1, 0, 0, 0],
                            [0, 0, 0, 0, 1, 0, 0],
                            [0, 0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testPrimaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
            }
        }
    }
    
    func secondaryDiagonalSpecs() {
        describe("Test a secondary diagonal of a squared grid") {
            var winnerTester: WinnerTestable!
            
            beforeEach {
                winnerTester = ClassicWinnerTester()
            }
            
            context("the grid is a 5x5 matrix") {
                context("that secondary diagonal contains exact 4 of 1s and 1 leading 0") {
                    it("testResult equals nil") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 0],
                            [0, 0, 0, 1, 0],
                            [0, 0, 1, 0, 0],
                            [0, 1, 0, 0, 0],
                            [1, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == nil
                    }
                }
                
                context("that secondary diagonal contains exact 4 of 1s and 1 trailing 0") {
                    it("testResult equals nil") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 1],
                            [0, 0, 0, 1, 0],
                            [0, 0, 1, 0, 0],
                            [0, 1, 0, 0, 0],
                            [0, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == nil
                    }
                }
                
                context("that secondary diagonal contains exact 4 of 1s and 1 leading 2") {
                    it("testResult equals nil") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 2],
                            [0, 0, 0, 1, 0],
                            [0, 0, 1, 0, 0],
                            [0, 1, 0, 0, 0],
                            [1, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == nil
                    }
                }
                
                context("that secondary diagonal contains exact 4 of 1s and 1 trailing 2") {
                    it("testResult equals nil") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 1],
                            [0, 0, 0, 1, 0],
                            [0, 0, 1, 0, 0],
                            [0, 1, 0, 0, 0],
                            [2, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == nil
                    }
                }
                
                context("that secondary diagonal contains exact 5 of 1s") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 1],
                            [0, 0, 0, 1, 0],
                            [0, 0, 1, 0, 0],
                            [0, 1, 0, 0, 0],
                            [1, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
            }
            
            context("the grid is a 6x6 matrix") {
                context("that secondary diagonal contains more than 5 of 1s") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 0, 1],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 1, 0, 0],
                            [0, 0, 1, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [1, 0, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
                
                context("that secondary diagonal contains exact 5 of 1s and 1 leading 0") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 0, 0],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 1, 0, 0],
                            [0, 0, 1, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [1, 0, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
                
                context("that secondary diagonal contains exact 5 of 1s and 1 trailing 0") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 0, 1],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 1, 0, 0],
                            [0, 0, 1, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [0, 0, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
                
                context("that secondary diagonal contains exact 5 of 1s and 1 of 0 interspersing among 1s") {
                    it("testResult equals nil") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 0, 1],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 0, 0],
                            [0, 0, 1, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [1, 0, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == nil
                    }
                }
                
                context("that secondary diagonal contains exact 5 of 1s and 1 leading 2") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 0, 2],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 1, 0, 0],
                            [0, 0, 1, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [1, 0, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
                
                context("that secondary diagonal contains exact 5 of 1s and 1 trailing 2") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 0, 1],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 1, 0, 0],
                            [0, 0, 1, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [2, 0, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
                
                context("that secondary diagonal contains exact 5 of 1s and 1 of 2 interspersing among 1s") {
                    it("testResult equals nil") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 0, 1],
                            [0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 2, 0, 0],
                            [0, 0, 1, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0],
                            [1, 0, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == nil
                    }
                }
            }
            
            context("the grid is a 7x7 matrix") {
                context("that secondary diagonal contains exact 5 of 1s, 1 leading 0 and 1 trailing 0") {
                    it("testResult equals 1") {
                        let grid: BoardGrid = [
                            [0, 0, 0, 0, 0, 0, 0],
                            [0, 0, 0, 0, 0, 1, 0],
                            [0, 0, 0, 0, 1, 0, 0],
                            [0, 0, 0, 1, 0, 0, 0],
                            [0, 0, 1, 0, 0, 0, 0],
                            [0, 1, 0, 0, 0, 0, 0],
                            [0, 0, 0, 0, 0, 0, 0],
                        ]
                        expect(winnerTester.testSecondaryDiagonal(row: 0, column: 0, grid: grid)) == 1
                    }
                }
            }
        }
    }
}
