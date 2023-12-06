Class {
	#name : #TakBoxElement,
	#superclass : #BlElement,
	#instVars : [
		'box',
		'board'
	],
	#classVars : [
		'ColorDictionary'
	],
	#category : #'TakToe-UI'
}

{ #category : #accessing }
TakBoxElement class >> box: aMBox [

	^ self new box: aMBox
]

{ #category : #'class initialization' }
TakBoxElement class >> initialize [ 

	ColorDictionary := { 
	nil -> Color lightGray .
	0 -> Color orange.
	1 -> Color black.} asDictionary 
	
	

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
"	self background: (self colorDictionary at: self box value).
	
"
    
    self background: (ColorDictionary at: self box value ifAbsent: [Color lightGray]).


]

{ #category : #public }
TakBoxElement >> clickbox [
		
    "Check if the box has already been clicked"
    self box value ifNil: [
        "Only allow clicking on an empty box"
        self board clickOnBox: self box.
        self changeColor
    ].

"
    | currentValue nextColor |
    ""Check if the box has already been clicked""
    currentValue := self box value.
    currentValue ifNil: [
        ""Only allow clicking on an empty box""
        self board clickOnBox: self box.
        
        ""Determine the color for the next click""
        nextColor := (currentValue isNil or: [currentValue = Color black]) ifTrue: [Color orange] ifFalse: [Color black].
        
        self box value: (TakBox valueDictionary at: nextColor).
        self changeColor.
    ]."
]

{ #category : #'as yet unclassified' }
TakBoxElement >> colorDictionary [

	^ ColorDictionary
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
