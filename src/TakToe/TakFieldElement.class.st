Class {
	#name : #TakFieldElement,
	#superclass : #BlElement,
	#instVars : [
		'board'
	],
	#category : #'TakToe-UI'
}

{ #category : #'as yet unclassified' }
TakFieldElement class >> launchLarge [
	^ self openWithModelLarge: (TakBoard generateWithSize: 3)
]

{ #category : #'as yet unclassified' }
TakFieldElement class >> launchRegular [
	^ self openWithModelRegular: (TakBoard generateWithSize: 3)
]

{ #category : #'as yet unclassified' }
TakFieldElement class >> launchSmall [

	^ self openWithModelSmall: (TakBoard generateWithSize: 3)
]

{ #category : #'as yet unclassified' }
TakFieldElement class >> openWithModelLarge: aTField [

	| aFieldElement space |
	space := BlSpace new.
	aFieldElement := self new
		                 board: aTField;
		                 yourself.
	space root addChild: aFieldElement.
	space pulse
		extent: 700 @ 700;
		resizable: false;
		show
]

{ #category : #'as yet unclassified' }
TakFieldElement class >> openWithModelRegular: aTField [

	| aFieldElement space |
	space := BlSpace new.
	aFieldElement := self new
		                 board: aTField;
		                 yourself.
	space root addChild: aFieldElement.
	space pulse
		extent: 500 @ 500;
		resizable: false;
		show
]

{ #category : #'as yet unclassified' }
TakFieldElement class >> openWithModelSmall: aTField [

	| aFieldElement space |
	space := BlSpace new.
	aFieldElement := self new
		                 board: aTField;
		                 yourself.
	space root addChild: aFieldElement.
	space pulse
		extent: 200 @ 200;
		resizable: false;
		show
]

{ #category : #accessing }
TakFieldElement >> board [

	^ board
]

{ #category : #accessing }
TakFieldElement >> board: aTBoard [

	board := aTBoard.
	self layout:
		(BlGridLayout horizontal cellSpacing: 5 - (board grid width // 5)).
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal matchParent.
		aLayoutConstraints vertical matchParent ].
	self padding: (BlInsets all: 5).
	self layout columnCount: board grid width.
	board grid do: [ :aBox |
		| boxElement |
		boxElement := (TakBoxElement  box: aBox ) board: aTBoard.
		self addChild: boxElement ]
]

{ #category : #accessing }
TakFieldElement >> initialize [

	super initialize.
	self background: (BlBackground paint: Color veryVeryLightGray ).
	
]
