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

{ #category : #actions }
TakBoard >> checkBottomLeftDiagonal: rowIndex column: columnIndex [ 
    | firstValue |
    firstValue := (self grid atColumn: 1 atRow: self grid height) value.

    " Check if all values in the bottom-left diagonal match the first value "
    ^ ((2 to: self grid width) allSatisfy: [ :i | 
        (self grid atColumn: i atRow: self grid height - i + 1) value = firstValue ]) ifTrue: [
            firstValue " Return the color if all values in the bottom-left diagonal match "
        ] ifFalse: [
            nil " Return nil if the bottom-left diagonal has mixed colors "
        ].
]

{ #category : #actions }
TakBoard >> checkBottomRightDiagonal: rowIndex column: columnIndex [ 
    | firstValue |
    firstValue := (self grid atColumn: self grid width atRow: self grid height) value.

    " Check if all values in the bottom-right diagonal match the first value "
    ^ ((self grid width - 1 to: 1 by: -1) allSatisfy: [ :i | 
        (self grid atColumn: self grid width - i + 1 atRow: self grid height - i + 1) value = firstValue ]) ifTrue: [
            firstValue " Return the color if all values in the bottom-right diagonal match "
        ] ifFalse: [
            nil " Return nil if the bottom-right diagonal has mixed colors "
        ].

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
TakBoard >> checkDiagonalsAtRow: rowIndex column: columnIndex [ 
    | topLeft bottomLeft topRight bottomRight |
    topLeft := self checkTopLeftDiagonal: rowIndex column: columnIndex.
    bottomLeft := self checkBottomLeftDiagonal: rowIndex column: columnIndex.
    topRight := self checkTopRightDiagonal: rowIndex column: columnIndex.
    bottomRight := self checkBottomRightDiagonal: rowIndex column: columnIndex.

    " Check if there's a winner in any diagonal"
    (topLeft notNil and: [topLeft = bottomLeft and: [topLeft = topRight and: [topLeft = bottomRight]]]) ifTrue: [
        ^ topLeft.
    ] ifFalse: [
        ^ nil.
    ].
]

{ #category : #actions }
TakBoard >> checkForWinnerAfterMoveAtRow: rowIndex column: columnIndex [ 
    | rowWinner columnWinner diagonalWinner |
    
    rowWinner := self checkRow: rowIndex.
    columnWinner := self checkColumn: columnIndex.
    diagonalWinner := self checkDiagonalsAtRow: rowIndex column: columnIndex.

    " Check if there's a winner"
    (rowWinner notNil and: [rowWinner = columnWinner and: [rowWinner = diagonalWinner]]) ifTrue: [
        ^ self isWinner: rowWinner.
    ] ifFalse: [
        " id full and no winner"
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

{ #category : #actions }
TakBoard >> checkTopLeftDiagonal: rowIndex column: columnIndex [ 
    | firstValue |
    firstValue := (self grid atColumn: 1 atRow: 1) value.

    " Check if all values in the top-left diagonal match the first value "
    ^ ((2 to: self grid width) allSatisfy: [ :i | 
        (self grid atColumn: i atRow: i) value = firstValue ]) ifTrue: [
            firstValue " Return the color if all values in the top-left diagonal match "
        ] ifFalse: [
            nil " Return nil if the top-left diagonal has mixed colors "
        ].
]

{ #category : #actions }
TakBoard >> checkTopRightDiagonal: rowIndex column: columnIndex [ 
    | firstValue |
    firstValue := (self grid atColumn: self grid width atRow: 1) value.

    " Check if all values in the top-right diagonal match the first value "
    ^ ((self grid width - 1 to: 1 by: -1) allSatisfy: [ :i | 
        (self grid atColumn: self grid width - i + 1 atRow: i) value = firstValue ]) ifTrue: [
            firstValue " Return the color if all values in the top-right diagonal match "
        ] ifFalse: [
            nil " Return nil if the top-right diagonal has mixed colors "
        ].

]

{ #category : #'player api' }
TakBoard >> clickOnBox: aTBox [
    | rowIndex columnIndex winnerColor |
    rowIndex := aTBox position y.
    columnIndex := aTBox position x.

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
    
    winner := winnerColor = 0 ifTrue: ['ORANGE'] ifFalse: ['BLACK'].
    container := BlElement new
                    background: Color gray;
                    layout: BlFrameLayout new;
                    constraintsDo: [ :c |
                        c horizontal matchParent.
                        c vertical matchParent ].

    (winnerColor notNil and: [winnerColor isInteger]) ifTrue: [
        container addChild: ((BlTextElement new text: ('Color', winner printString, ' wins! Press space to reset the game.'
                        asRopedText
                            fontName: 'Phosphate'; bold;
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
