Class {
	#name : #TakBoxElement,
	#superclass : #BlElement,
	#instVars : [
		'box',
		'board'
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
		
    "Check if the box has already been clicked"
"    self box value ifNil: [
        self board clickOnBox: self box.
        self changeColor
    ]."
  
   | currentValue nextColor |
    currentValue := self box value.
    
    "Check if the box has already been clicked"
    currentValue ifNil: [
        "Only allow clicking on an empty box"
        self board clickOnBox: self box.
        
        "Determine the color for the next click"
        nextColor := (currentValue isNil or: [currentValue = 0]) ifTrue: [1] ifFalse: [0].
        
        self box value: nextColor.
        self changeColor.
].
]

{ #category : #public }
TakBoxElement >> initialize [
	super initialize.
	
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	self constraintsDo: [ :aLayoutConstraints |
		aLayoutConstraints horizontal matchParent.
		aLayoutConstraints vertical matchParent ].

	self addEventHandlerOn: BlMouseUpEvent do: [ :anEvent | self clickbox ]
]
