Class {
	#name : #TakBoard,
	#superclass : #MygBoard,
	#instVars : [
		'magnifier'
	],
	#category : #'TakToe-Core'
}

{ #category : #'instance creation' }
TakBoard class >> generateWithSize: aNumber [

	^ (self newSquaredSize: aNumber)
		  yourself
]

{ #category : #level }
TakBoard class >> level [

	| lev |
	lev := '___
___
___'.


	^ self configureGrid:
		  (MygLevelImporter fromString: lev fromPackage: self package)
]

{ #category : #'instance creation' }
TakBoard class >> newSquaredSize: aNumber [

	^ self new
		  configureGrid: (CTNewArray2D
				   width: aNumber
				   height: aNumber
				   tabulate: [ :x :y | TakEmptyBox new])
]

{ #category : #testing }
TakBoard >> checkIfFinished [

	"(self isFull and: [ self isValid ]) ifTrue: [ self endGame ]"
	(self isFull ) ifTrue: [ self endGame ]
]

{ #category : #'player api' }
TakBoard >> clickOnBox: aTBox [

	| box |
	box := self grid atColumn: aTBox position x atRow: aTBox position y.

	box configureValue.
	self checkIfFinished
]

{ #category : #actions }
TakBoard >> endGame [

	| container space |
	container := BlElement new
		             background: Color veryDarkGray;
		             layout: BlFrameLayout new;
		             constraintsDo: [ :c |
			             c horizontal matchParent.
			             c vertical matchParent ].

	container addChild: ((BlTextElement new text: ('End Of Game' asRopedText
				   fontName: 'Phosphate'; bold;
				   foreground: Color white;
				   fontSize: 50)) constraintsDo: [ :c |
			 c frame horizontal alignCenter.
			 c frame vertical alignCenter ]).

	space := BlSpace new.
	space root addChild: container.
	space
		pulse;
		extent: 300 @ 300;
		show.
	^ space
]

{ #category : #testing }
TakBoard >> isFull [ 
	
	^ (self grid contents anySatisfy: [ :each | each value isNil ]) not
]

{ #category : #accessing }
TakBoard >> magnifier [ 
	^ magnifier
]

{ #category : #accessing }
TakBoard >> magnifier: aNumber [
	magnifier := aNumber 
]

{ #category : #accessing }
TakBoard >> width [
	^ grid width
]
