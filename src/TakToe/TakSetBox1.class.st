Class {
	#name : #TakSetBox1,
	#superclass : #TakBox,
	#category : #'TakToe-Core'
}

{ #category : #'default encoding' }
TakSetBox1 class >> textualMapCharacter [ 
	^ $1
]

{ #category : #initialization }
TakSetBox1 >> initialize [

	super initialize.
	value := 1
]
