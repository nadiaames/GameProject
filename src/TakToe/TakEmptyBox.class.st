Class {
	#name : #TakEmptyBox,
	#superclass : #TakBox,
	#category : #'TakToe-Core'
}

{ #category : #'default encoding' }
TakEmptyBox class >> textualMapCharacter [ 
	^ $_
]

{ #category : #initialization }
TakEmptyBox >> initialize [

	super initialize.
	value := nil
]

{ #category : #testing }
TakEmptyBox >> isTakEmptyBox [ 
	
	^ true 
]
