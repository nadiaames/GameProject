Class {
	#name : #TFieldElement,
	#superclass : #BlElement,
	#instVars : [
		'game'
	],
	#category : #'TakToe-UI'
}

{ #category : #accessing }
TFieldElement >> game [ 
	^ game
]

{ #category : #accessing }
TFieldElement >> game: aTField [

	game := aTField.
	self padding: (BlInsets all: 5 * game magnifier).
	self layout columnCount: game width.
	game grid do: [ :aBox |
		| boxElement |
		boxElement := (MBoxElement createWithBox: aBox)
			              field: aTField;
			              positionInField: aBox position.
		self addChild: boxElement ]
]
