Class {
	#name : #TakFieldElement,
	#superclass : #BlElement,
	#instVars : [
		'game'
	],
	#category : #'TakToe-UI'
}

{ #category : #'as yet unclassified' }
TakFieldElement class >> launchLarge [
	^ self withMatrixTest5x5WithMagnifier: 2
]

{ #category : #'as yet unclassified' }
TakFieldElement class >> launchRegular [
	^ self withMatrixTest5x5 
]

{ #category : #'as yet unclassified' }
TakFieldElement class >> launchSmall [
	^ self withMatrixTest5x5WithMagnifier: 0.5
]

{ #category : #'as yet unclassified' }
TakFieldElement class >> launchVeryLarge [
	^ self withMatrixTest5x5WithMagnifier: 4
]

{ #category : #'as yet unclassified' }
TakFieldElement class >> openWithModel: aModel [
	^ self openWithModel: aModel withMagnifier: 1
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

{ #category : #'as yet unclassified' }
TakFieldElement class >> withMatrixTest5x5 [
	^ self openWithModel: TakBoard matrixTest5x5
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
	self padding: (BlInsets all: 9 * game magnifier).
	self layout columnCount: game width.
	game grid do: [ :aBox |
		| boxElement |
		boxElement := (TakBoxElement createWithBox: aBox)
			              field: aTField;
			              positionInField: aBox position.
		self addChild: boxElement ]
]

{ #category : #initialization }
TakFieldElement >> initialize [
	super initialize.
	self background: (BlBackground paint: Color veryVeryLightGray).
	self layout: (BlGridLayout horizontal cellSpacing: 5).
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal fitContent.
		aLayoutConstraints vertical fitContent ]
]
