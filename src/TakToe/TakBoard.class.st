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
 | winnerColor | 

    (self isFull ) ifTrue: [ self endGame ].

    (self grid rowsDo: [ :row |
        winnerColor := self checkRow: row. 
        winnerColor ifNotNil: [^ self isWinner: winnerColor].
    ]).
    
    (self grid columnsDo: [ :column |
        winnerColor := self checkColumn: column.
        winnerColor ifNotNil: [^ self isWinner: winnerColor].
    ]).
    
    winnerColor := self checkDiagonalFrom: 1@1 to: (self grid width)@(self grid height).
    winnerColor ifNotNil: [^ self isWinner: winnerColor].
    
    winnerColor := self checkDiagonalFrom: (self grid width)@1 to: 1@(self grid height).
    winnerColor ifNotNil: [^ self isWinner: winnerColor].
    
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

 | box currentValue nextValue |
    box := self grid atColumn: aTBox position x atRow: aTBox position y.
    currentValue := box value.
    
    "Toggle box value between 0 and 1"
    nextValue := currentValue ifNil: [0] ifNotNil: [currentValue = 0 ifTrue: [1] ifFalse: [0]].
    
    "Update box value and configure"
    box value: nextValue.
    box configureValue.
    self checkIfFinished.
]

{ #category : #actions }
TakBoard >> endGame [

	| container space |
	container := BlElement new
		             background: Color black ;
		             layout: BlFrameLayout new;
		             constraintsDo: [ :c |
			             c horizontal matchParent.
			             c vertical matchParent ].

	container addChild: ((BlTextElement new text: ('It''s a draw! No Winner. Press space to reset the game.' asRopedText
                    fontName: 'Phosphate'; bold;
				   foreground: Color orange;
				   fontSize: 30)) constraintsDo: [ :c |
			 c frame horizontal alignCenter.
			 c frame vertical alignCenter.]).


	space := BlSpace new.
	space root addChild: container.
	space
		pulse;
		extent: 700 @ 200;
		show.
	^ space
]

{ #category : #testing }
TakBoard >> isFull [ 
	
	^ (self grid contents anySatisfy: [ :each | each value isNil ]) not
]

{ #category : #testing }
TakBoard >> isWinner: winnerColor [ 
    "Show the endGame container with the winner color (or nil if it's a draw)"
    | container space |
    container := BlElement new
                    background: Color black;
                    layout: BlFrameLayout new;
                    constraintsDo: [ :c |
                        c horizontal matchParent.
                        c vertical matchParent ].

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

{ #category : #accessing }
TakBoard >> width [
	^ grid width
]
