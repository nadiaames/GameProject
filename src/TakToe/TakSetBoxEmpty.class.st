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

	self value: (value ifNil: [ 0 ] ifNotNil: ["
			 value = 0
				 ifTrue: [ 1 ]
				 ifFalse: [ nil ]" ])
]

{ #category : #initialization }
TakSetBoxEmpty >> initialize [

	super initialize.
	value := nil
]
