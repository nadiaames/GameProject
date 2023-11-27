Class {
	#name : #TakToe,
	#superclass : #Object,
	#category : #'TakToe-UI'
}

{ #category : #accessing }
TakToe class >> menuBar [

	| bar |
	bar := ToMenuBar new
		       hMatchParent;
		       vFitContent.
	bar
		background: Color veryVeryLightGray;
		border: (BlBorder paint: Color veryDarkGray).
	^ bar
]

{ #category : #'instance creation' }
TakToe class >> menuHelp [

	| menu |
	menu := ToMenu new.
	menu label: (ToLabel text: 'Help').
	menu icon:
		(ToImage inner: (Smalltalk ui icons iconNamed: #glamorousHelp)).
	menu whenClickedDo: [
		| container lab space |
		lab := ToLabel text: 'Welcome to TakToe, the fusion of Takuzu and Tic Tac Toe, where strategy meets simplicity in this unique and engaging game! 

How to play:

In this thrilling game, you''ll be engaging in a strategic showdown of wits as you strive to align three of your chosen color—either vibrant Orange or bold Black—along the 3x3 grid. 
Each turn is an opportunity to strategically place your colored token in an empty cell, aiming to create a winning combination either horizontally, vertically, or diagonally. Be on the lookout for potential victories and cleverly block your opponent''s path to triumph. 
The game concludes with the declaration of the winner, the master of color alignment. 

Enjoy the game!
'.
		lab beMultiLine.
		lab hMatchParent.				
		container := BlElement new
			             background: Color lightGray;
			             padding: (BlInsets all: 15);
			             layout: BlLinearLayout vertical;
			             constraintsDo: [ :c |
				             c horizontal fitContent.
				             c vertical fitContent ].
		container addChild: lab.
		space := BlSpace new.
		space root
			layout: BlFrameLayout new;
			addChild: container;
			constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical fitContent ].
		space pulse.
		space extent: container extent.
		space show ].
	^ menu
]

{ #category : #'instance creation' }
TakToe class >> menuPlay [ 
	|menu|
	menu := ToMenu new.
	menu label: (ToLabel text:'  Play').
	menu icon:
		(ToImage inner: (Smalltalk ui icons iconNamed: #smallDoIt)).
		
	menu addItem:
		((ToButtonMenuItem new labelText: 'Small') whenClickedDo: [
			 TakFieldElement launchSmall ]).
	menu addItem:
		((ToButtonMenuItem new labelText: 'Regular') whenClickedDo: [
			 TakFieldElement launchRegular ]).
	menu addItem:
		((ToButtonMenuItem new labelText: 'Large') whenClickedDo: [
			 TakFieldElement launchLarge ]).
		
	^ menu
	
]

{ #category : #'instance creation' }
TakToe class >> open [

	| space playMenu helpMenu title bar|
	
	playMenu := self menuPlay.
	helpMenu := self menuHelp.
	
	bar := self menuBar.
	title := self title.
	
	bar addMenu: playMenu.
	bar addMenu: helpMenu.

	space := BlSpace new.

	space root addChild: title.
	space root addChild: bar.
	space extent: 300 @ 300.
	space show
]

{ #category : #accessing }
TakToe class >> title [

	| title  |
	title := BlElement new background: Color orange.
	title constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	title layout: BlFrameLayout new.
	title addChild: ((BlTextElement new text: ('TakToe' asRopedText
				   fontName: 'Source Code Pro';
				   foreground: Color black; bold;
				   fontSize: 70)) constraintsDo: [ :c |
			 c frame horizontal alignCenter.
			 c frame vertical alignCenter ]).
	^ title
]
