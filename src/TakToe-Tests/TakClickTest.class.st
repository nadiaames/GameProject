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
