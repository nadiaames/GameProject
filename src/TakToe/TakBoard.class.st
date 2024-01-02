Class {
	#name : #TakBoard,
	#superclass : #MygBoard,
	#instVars : [
		'currentColor',
		'winner'
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
				   tabulate: [ :x :y | TakSetBoxEmpty  new])
]

{ #category : #testing }
TakBoard >> checkColumn: columnIndex [ 
    | firstValue |
    firstValue := (self grid atColumn: columnIndex atRow: 1) value.

    "Check if all values in the column match the first value"
    ^ ((2 to: self grid height) allSatisfy: [ :row | 
        (self grid atColumn: columnIndex atRow: row) value = firstValue ]) ifTrue: [
            firstValue "Return the color if all values in the column match"
        ] ifFalse: [
            nil "Return nil if the column has mixed colors"
        ].
]

{ #category : #actions }
TakBoard >> checkForWinnerAfterMoveAtRow: rowIndex column: columnIndex [ 
  | rowWinner columnWinner |
    
    rowWinner := self checkRow: rowIndex.
    columnWinner := self checkColumn: columnIndex.

    " Check if there's a winner"
    (rowWinner notNil and: [rowWinner = columnWinner]) ifTrue: [
        ^ self isWinner: rowWinner.
    ] ifFalse: [
        " Check if the board is full to declare a draw "
        (self isFull) ifTrue: [
            ^ self isWinner: nil. " Indicate a draw when the board is full and no winner "
        ].
    ].

    ^ nil.
]

{ #category : #testing }
TakBoard >> checkRow: rowIndex [ 

    | firstValue |
    firstValue := (self grid atColumn: 1 atRow: rowIndex) value.

    "Check if all values in the row match the first value"
    ^ ((2 to: self grid width) allSatisfy: [ :col | 
        (self grid atColumn: col atRow: rowIndex) value = firstValue ]) ifTrue: [
            firstValue "Return the color if all values in the row match"
        ] ifFalse: [
            nil "Return nil if the row has mixed colors"
        ].


]

{ #category : #'player api' }
TakBoard >> clickOnBox: aTBox [

    | rowIndex columnIndex winnerColor |
    rowIndex := aTBox position y.
    columnIndex := aTBox position x.

    "Check for winner in the row and column after the move"
    winnerColor := self checkForWinnerAfterMoveAtRow: rowIndex column: columnIndex.
    winnerColor ifNotNil: [^ self isWinner: winnerColor].

    ^ nil






]

{ #category : #actions }
TakBoard >> initialize [
super initialize.
    currentColor := nil.
    winner := nil.

]

{ #category : #testing }
TakBoard >> isFull [ 
	
	^ (self grid contents anySatisfy: [ :each | each value isNil ]) not
]

{ #category : #testing }
TakBoard >> isWinner: winnerColor [ 
    | container space |
    
    winner := winnerColor = 0 ifTrue: ['Orange'] ifFalse: ['Black'].
    container := BlElement new
                    background: Color gray;
                    layout: BlFrameLayout new;
                    constraintsDo: [ :c |
                        c horizontal matchParent.
                        c vertical matchParent ].

    (winnerColor notNil and: [winnerColor isInteger]) ifTrue: [
        container addChild: ((BlTextElement new text: ("'Player',winner,' Wins! Press space to reset the game.'" 'Player Wins! Press space to reset the game.'
                        asRopedText
                        foreground: Color black;
                        fontSize: 20)) constraintsDo: [ :c |
                    c frame horizontal alignCenter.
                    c frame vertical alignCenter ]).
    ] ifFalse: [
        container addChild: ((BlTextElement new text: ('It''s a draw! No Winner. Press space to reset the game.'
                        asRopedText
                        fontName: 'Phosphate'; bold;
                        foreground: Color black;
                        fontSize: 20)) constraintsDo: [ :c |
                    c frame horizontal alignCenter.
                    c frame vertical alignCenter ]).
    ].

    space := BlSpace new.
    space root addChild: container.
    space
        pulse;
        extent: 500 @ 150;
        show.
    ^ space
]

{ #category : #accessing }
TakBoard >> width [
	^ grid width
]
