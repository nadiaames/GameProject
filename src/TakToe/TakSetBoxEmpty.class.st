Class {
	#name : #TakSetBoxEmpty,
	#superclass : #TakBox,
	#category : #'TakToe-Core'
}

{ #category : #'default encoding' }
TakSetBoxEmpty class >> textualMapCharacter [ 
	^ $_
]

{ #category : #initialization }
TakSetBoxEmpty >> clickOnEmpty [
	"change the box value to its next state (nil -> 0)"

	self value: (value ifNil: [ 0 ] ifNotNil: [])
]
