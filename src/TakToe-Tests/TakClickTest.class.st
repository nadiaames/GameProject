Class {
	#name : #TakClickTest,
	#superclass : #TestCase,
	#category : #'TakToe-Tests'
}

{ #category : #tests }
TakClickTest >> testBoxEmptylick [
	|box|
	box := TakSetBoxEmpty new.
	self assert: box value isNil.
	box clickOnEmpty .
	self assert: box value equals: 0. 
]

{ #category : #tests }
TakClickTest >> testDraw [ 
    | board |
    board := TakBoard newSquaredSize: 3.
    board clickOnBox: (board grid atColumn: 1 atRow: 1).
    board clickOnBox: (board grid atColumn: 2 atRow: 2).
    board clickOnBox: (board grid atColumn: 3 atRow: 3).
    board clickOnBox: (board grid atColumn: 1 atRow: 2).
    board clickOnBox: (board grid atColumn: 2 atRow: 1).
    board clickOnBox: (board grid atColumn: 3 atRow: 2).
    board clickOnBox: (board grid atColumn: 1 atRow: 3).
    board clickOnBox: (board grid atColumn: 2 atRow: 3).
    board clickOnBox: (board grid atColumn: 3 atRow: 1).

    self assert: (board isWinner: nil) equals: true.
]
