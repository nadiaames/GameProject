Class {
	#name : #TakFieldElement,
	#superclass : #BlElement,
	#instVars : [
		'game'
	],
	#category : #'TakToe-UI'
}

{ #category : #'as yet unclassified' }
TakFieldElement class >> launchSmall [
	^ self withMatrixTest5x5WithMagnifier: 0.5
]

{ #category : #'as yet unclassified' }
TakFieldElement class >> openWithModel: aModel withMagnifier: aNumber [

	| aGameElement space |
	space := BlSpace new.
	"Create the game model and the Bloc element."
	aGameElement := self new
		                game: (aModel magnifier: aNumber);
		                yourself.

	"The space represents the window"

	space root addChild: aGameElement.

	"Calculate the extent of the game board for the first time, to set it to the window."
	space pulse.
	space extent: aGameElement extent.
	space resizable: false.
	space show.
	^ space
]

{ #category : #execution }
TakFieldElement class >> withMatrixTest5x5WithMagnifier: aNumber [

	^ self openWithModel: TakBoard matrixTest5x5 withMagnifier: aNumber 
]

{ #category : #accessing }
TakFieldElement >> game [ 
	^ game
]

{ #category : #accessing }
TakFieldElement >> game: aTField [

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
