Class {
	#name : #BaselineOfTicTacToe,
	#superclass : #BaselineOf,
	#category : #BaselineOfTicTacToe
}

{ #category : #baselines }
BaselineOfTicTacToe >> baseline: spec [
	<baseline>

	spec
		baseline: 'Myg'
		with: [ spec repository: 'github://Ducasse/Myg:v1.0.1/src' ].

	spec
		package: 'TakToe' 
		with: [ spec requires: #( 'Myg' ) ];
		package: 'TakToe-Tests'
		with: [ spec requires: #( 'TakToe' ) ] 
]
