Class {
	#name : #TakBoard,
	#superclass : #MygBoard,
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
TakBoard >> checkColumn: aColumn [ 
    "Check if a column contains three boxes with the same color"
    | uniqueColors |
    uniqueColors := (aColumn select: [ :box | box value notNil ] thenCollect: [ :box | box value ]).

    "If there is exactly one unique color, return it; otherwise, return nil"
    ^ uniqueColors size = 1 ifTrue: [ uniqueColors first ] ifFalse: [ nil ].

]

{ #category : #testing }
TakBoard >> checkDiagonalFrom: startPoint to: endPoint [ 
    "Check if a diagonal from startPoint to endPoint contains three boxes with the same color"
    | uniqueColors diagonalBoxes |
    diagonalBoxes := OrderedCollection new.

    (startPoint to: endPoint) do: [ :point |
        diagonalBoxes add: (self grid atColumn: point x atRow: point y).
    ].

    uniqueColors := (diagonalBoxes select: [ :box | box value notNil ] thenCollect: [ :box | box value ]).

    "If there is exactly one unique color, return it; otherwise, return nil"
    ^ uniqueColors size = 1 ifTrue: [ uniqueColors first ] ifFalse: [ nil ].

]

{ #category : #testing }
TakBoard >> checkIfFinished [

	"(self isFull and: [ self isValid ]) ifTrue: [ self endGame ]"
	(self isFull ) ifTrue: [ self endGame ]"
	
    ""Check if the game is finished (e.g., a player has won)""
    | winnerColor |
    
    ""Check for horizontal win""
    (self grid rowsDo: [ :row |
        winnerColor := self checkRow: row.
        winnerColor ifNotNil: [^ self endGame: winnerColor].
    ]) ifNotNil: [^ self endGame: winnerColor].

    ""Check for vertical win""
    (self grid columnsDo: [ :column |
        winnerColor := self checkColumn: column.
        winnerColor ifNotNil: [^ self endGame: winnerColor].
    ]) ifNotNil: [^ self endGame: winnerColor].

    ""Check for diagonal win (top-left to bottom-right)""
    winnerColor := self checkDiagonalFrom: 1@1 to: (self grid width)@(self grid height).
    winnerColor ifNotNil: [^ self endGame: winnerColor].

    ""Check for diagonal win (top-right to bottom-left)""
    winnerColor := self checkDiagonalFrom: (self grid width)@1 to: 1@(self grid height).
    winnerColor ifNotNil: [^ self endGame: winnerColor].

    ""Check if the board is full without a winner""
    (self isFull) ifTrue: [^ self endGame: nil]."
]

{ #category : #testing }
TakBoard >> checkRow: aRow [ 
    "Check if a row contains three boxes with the same color"
    | uniqueColors |
    uniqueColors := (aRow select: [ :box | box value notNil ] thenCollect: [ :box | box value ]).

    "If there is exactly one unique color, return it; otherwise, return nil"
    ^ uniqueColors size = 1 ifTrue: [ uniqueColors first ] ifFalse: [ nil ].

]

{ #category : #'player api' }
TakBoard >> clickOnBox: aTBox [

	| box |
	box := self grid atColumn: aTBox position x atRow: aTBox position y.

	box configureValue.
	self checkIfFinished.
	
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
TakBoard >> endGame: winnerColor [ 
    "Show the endGame container with the winner color (or nil if it's a draw)"
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

    "Append the winner message if there's a winner"
    (winnerColor notNil and: [winnerColor isInteger]) ifTrue: [
        container addChild: ((BlTextElement new text: ('Player  Wins!'
                        asRopedText
                        fontName: 'Phosphate'; bold;
                        foreground: Color white;
                        fontSize: 30)) constraintsDo: [ :c |
                    c frame horizontal alignCenter.
                    c frame vertical alignCenter ]).
    ].

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
TakBoard >> width [
	^ grid width
]
