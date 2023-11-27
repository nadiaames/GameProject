Class {
	#name : #TakSetBox0,
	#superclass : #TakBox,
	#category : #'TakToe-Core'
}

{ #category : #'default encoding' }
TakSetBox0 class >> textualMapCharacter [
	^ $0
]

{ #category : #initialization }
TakSetBox0 >> initialize [

	super initialize.
	value := 0
]
