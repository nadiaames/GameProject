Class {
	#name : #TakBox,
	#superclass : #MygAbstractBox,
	#instVars : [
		'value'
	],
	#category : #'TakToe-Core'
}

{ #category : #evaluating }
TakBox >> value [ 
	^ value 
]

{ #category : #evaluating }
TakBox >> value: aNumber [

	value := aNumber
]
