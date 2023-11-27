Class {
	#name : #TakBoard,
	#superclass : #MygBoard,
	#instVars : [
		'magnifier'
	],
	#category : #'TakToe-Core'
}

{ #category : #'instance creation' }
TakBoard class >> createWithMatrix: aMatrix [

	^ self new
		  configureGrid: aMatrix;
		  yourself
]

{ #category : #level4 }
TakBoard class >> level1 [

	| level |
	level := '___
___
___'.


	^ self configureGrid:
		  (MygLevelImporter fromString: level fromPackage: self package)
]

{ #category : #'instance creation' }
TakBoard class >> matrixTest5x5 [

	^ self createWithMatrix:
		  (CTNewArray2D width: 3 height: 3 tabulate: [ :column :row |
			   MBox randomCase ])
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
