Class {
	#name : #TakBoxElement,
	#superclass : #BlElement,
	#instVars : [
		'box',
		'board'
	],
	#classVars : [
		'currentColor',
		'winner'
	],
	#category : #'TakToe-UI'
}

{ #category : #accessing }
TakBoxElement class >> box: aMBox [

	^ self new box: aMBox
]

{ #category : #accessing }
TakBoxElement >> board [

	^ board
]

{ #category : #accessing }
TakBoxElement >> board: aTBoard [

	board := aTBoard
]

{ #category : #accessing }
TakBoxElement >> box [ 
	^ box
]

{ #category : #accessing }
TakBoxElement >> box: aTBox [
	box := aTBox.
	self changeColor 

]

{ #category : #public }
TakBoxElement >> changeColor [

"    self background: (ColorDictionary at: self box value ifAbsent: [Color veryVeryLightGray ]).
"  
  | boxValue colorToSet |
    boxValue := self box value.
    colorToSet := boxValue ifNil: [ Color veryVeryLightGray ] ifNotNil: [ boxValue = 0 ifTrue: [ Color orange ] ifFalse: [ Color black ] ].
    
    self background: colorToSet.

]

{ #category : #public }
TakBoxElement >> clickbox [
		
    | currentValue nextColor |
    currentValue := self box value.
    
    currentValue ifNil: [
        self board clickOnBox: self box.
        
        nextColor := (currentColor isNil or: [currentColor = 0]) ifTrue: [1] ifFalse: [0].
        
        self box value: nextColor.
        self changeColor.
        currentColor := nextColor. 
    ].
]

{ #category : #public }
TakBoxElement >> initialize [
	super initialize.
	self constraintsDo: [ :aLayoutConstraints |
				aLayoutConstraints horizontal matchParent.
				aLayoutConstraints vertical matchParent ].
		
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 100).
	self addEventHandlerOn: BlMouseUpEvent do: [ :anEvent | self clickbox ].
]
