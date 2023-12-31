Class {
	#name : #TakBox,
	#superclass : #MygAbstractBox,
	#instVars : [
		'value'
	],
	#classVars : [
		'ValueDictionary'
	],
	#category : #'TakToe-Core'
}

{ #category : #accessing }
TakBox class >> valueDictionary [ 

	^ ValueDictionary 
]

{ #category : #accessing }
TakBox >> configureValue [
	
	self value: (self valueDictionary at: self value).
]

{ #category : #evaluating }
TakBox >> value [ 
	^ value 
]

{ #category : #evaluating }
TakBox >> value: aNumber [

	value := aNumber
]

{ #category : #accessing }
TakBox >> valueDictionary [

	^ ValueDictionary
]
