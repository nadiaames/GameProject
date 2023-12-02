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
TakSetBoxEmpty >> initialize [

	super initialize.
	value := nil
]
