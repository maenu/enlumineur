"
There is a big warning about the design of these tests. 
The context is not initialized so that we are sure about the configuration we are building. 

"
Class {
	#name : #BIEnlumineurTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'configurationSelector',
		'formatterClass',
		'contextClass'
	],
	#category : #'Enlumineur-Tests'
}

{ #category : #'building suites' }
BIEnlumineurTest class >> testParameters [

	^ ParametrizedTestMatrix new
			addCase: { #formatterClass -> BIEnlumineurFormatter. #contextClass -> BIEnlumineurContext };
		yourself.
]

{ #category : #accessing }
BIEnlumineurTest >> contextClass [
	^ contextClass
]

{ #category : #accessing }
BIEnlumineurTest >> contextClass: anObject [
	contextClass := anObject
]

{ #category : #hooks }
BIEnlumineurTest >> formatExpression: anExpression [

	| expr |
	expr := self parseExpression: anExpression.
	^ self formatter format: expr.
	
]

{ #category : #hooks }
BIEnlumineurTest >> formatter [
	^ self formatterClass new
		installNewContext: (self perform: configurationSelector)
		yourself
]

{ #category : #hooks }
BIEnlumineurTest >> formatterClass [

	^ formatterClass
]

{ #category : #hooks }
BIEnlumineurTest >> formatterClass: aFormatterClass [
	formatterClass := aFormatterClass
]

{ #category : #hooks }
BIEnlumineurTest >> parseExpression: anExpression [

	^ self parserClass parseExpression: anExpression
]

{ #category : #hooks }
BIEnlumineurTest >> parserClass [
	^ RBParser
]

{ #category : #test }
BIEnlumineurTest >> testLookAheadCodeIsResetWhenChangingConfiguration [
	"This is a test to show that the formatter got a problem with a cache. When we execute two formatting passes one after the other and changed the context. Some nodes are not formatted with the new context but with the old. This is due to a cache used by the formatter."
	
	| prettyPrinterInstance context1 context2 astNode res1 res2 |
	context1 := BIEnlumineurContext new.
	context2 := BIEnlumineurContext new lineUpBlockBrackets: true.
	prettyPrinterInstance := BIEnlumineurFormatter new installNewContext: context1.
	astNode := RBParser parseExpression: 
	'1 to: 4 do: [ :i | 
		Transcript
			show: i;
			cr;
			cr]'.
	
	res1 := prettyPrinterInstance format: astNode.
	res2 := (prettyPrinterInstance installNewContext: context2) format: astNode.
	
	self deny: res1 equals: res2
]
