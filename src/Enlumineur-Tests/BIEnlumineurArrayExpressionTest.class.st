Class {
	#name : #BIEnlumineurArrayExpressionTest,
	#superclass : #BIEnlumineurTest,
	#category : #'Enlumineur-Tests'
}

{ #category : #configurations }
BIEnlumineurArrayExpressionTest >> basicConfiguration [

	^ self contextClass basicNew
		formatCommentCloseToStatements: false;
		maxLineLength: 50;
		numberOfSpacesInsideParentheses: 0;
		retainBlankLinesBetweenStatements: false;
		minimumNewLinesBetweenStatements: 1;
		indentStyle: #tabulation;
		indentExtraSpaces: 0;
		periodAtEndOfBlock: false;
		periodAtEndOfMethod: false;
		numberOfSpacesInsideArray: 0;
		numberOfSpacesBeforeDotInDynamicArray: 0.
		"here since we shortcut the initialize method we have to set the numberOfSpace...
		manually so that the spacesBefore string is correctly computed." 
]

{ #category : #configurations }
BIEnlumineurArrayExpressionTest >> fiveSpacesInsideArrayConfiguration [

	^ self contextClass basicNew
		formatCommentCloseToStatements: false;
		maxLineLength: 50;
		numberOfSpacesInsideParentheses: 0;
		retainBlankLinesBetweenStatements: false;
		minimumNewLinesBetweenStatements: 1;
		indentStyle: #tabulation;
		indentExtraSpaces: 0;
		periodAtEndOfBlock: false;
		periodAtEndOfMethod: false;
		numberOfSpacesInsideArray: 5;
		numberOfSpacesBeforeDotInDynamicArray: 0.
		"here since we shortcut the initialize method we have to set the numberOfSpace...
		manually so that the spacesBefore string is correctly computed." 
]

{ #category : #configurations }
BIEnlumineurArrayExpressionTest >> maxLineLengthConfiguration [
	"Here we can control explicitely the configuration we want."

	" String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]"

	^ self contextClass basicNew
		formatCommentCloseToStatements: false;
		maxLineLength: 12;
		retainBlankLinesBetweenStatements: false;
		minimumNewLinesBetweenStatements: 1;
		indentStyle: #tabulation;
		periodAtEndOfBlock: false;
		periodAtEndOfMethod: false;
		indentExtraSpaces: 0;
		numberOfSpacesInsideArray: 0;
		numberOfSpacesBeforeDotInDynamicArray: 0.
		"here since we shortcut the initialize method we have to set the numberOfSpace...
		manually so that the spacesBefore string is correctly computed." 
]

{ #category : #configurations }
BIEnlumineurArrayExpressionTest >> maxLineLengthConfigurationWithSpaceBefore [
	"Here we can control explicitely the configuration we want."

	" String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]"

	^ self contextClass basicNew
		formatCommentCloseToStatements: false;
		maxLineLength: 12;
		retainBlankLinesBetweenStatements: false;
		minimumNewLinesBetweenStatements: 1;
		indentStyle: #tabulation;
		periodAtEndOfBlock: false;
		periodAtEndOfMethod: false;
		indentExtraSpaces: 0;
		numberOfSpacesInsideArray: 0;
		numberOfSpacesBeforeDotInDynamicArray: 1.
		"here since we shortcut the initialize method we have to set the numberOfSpace...
		manually so that the spacesBefore string is correctly computed." 
]

{ #category : #configurations }
BIEnlumineurArrayExpressionTest >> multiLineConfiguration [

	^ self contextClass basicNew
		formatCommentCloseToStatements: false;
		maxLineLength: 50;
		numberOfSpacesInsideParentheses: 0;
		retainBlankLinesBetweenStatements: false;
		minimumNewLinesBetweenStatements: 1;
		indentStyle: #tabulation;
		periodAtEndOfBlock: false;
		periodAtEndOfMethod: false;
		numberOfSpacesInsideParentheses: 0;
		multiLineMessages: #();
		oneLineMessages: #();
		numberOfArgumentsForMultiLine: 4;
		indentsForKeywords: 1;
		keepBlockInMessage: true;
		indentExtraSpaces: 0;
		numberOfSpacesInsideArray: 0;
		numberOfSpacesBeforeDotInDynamicArray: 0
]

{ #category : #configurations }
BIEnlumineurArrayExpressionTest >> oneSpaceInsideArrayConfiguration [

	^ self contextClass basicNew
		formatCommentCloseToStatements: false;
		maxLineLength: 50;
		numberOfSpacesInsideParentheses: 0;
		retainBlankLinesBetweenStatements: false;
		minimumNewLinesBetweenStatements: 1;
		indentStyle: #tabulation;
		indentExtraSpaces: 0;
		periodAtEndOfBlock: false;
		periodAtEndOfMethod: false;
		numberOfSpacesInsideArray: 1;
		numberOfSpacesBeforeDotInDynamicArray: 0.
		"here since we shortcut the initialize method we have to set the numberOfSpace...
		manually so that the spacesBefore string is correctly computed." 
]

{ #category : #configurations }
BIEnlumineurArrayExpressionTest >> periodAtEndOfMethod [
	"Here we can control explicitely the configuration we want."

	" String streamContents: [:s |
			BIPrettyPrinterContext new storeOn: s]"

	^ self contextClass basicNew
		formatCommentCloseToStatements: false;
		maxLineLength: 12;
		indentsForKeywords: 0;
		retainBlankLinesBetweenStatements: false;
		minimumNewLinesBetweenStatements: 1;
		indentStyle: #tabulation;
		indentExtraSpaces: 0;
		periodAtEndOfBlock: false;
		periodAtEndOfMethod: true;
		multiLineMessages: #();
		oneLineMessages: #();
		numberOfSpacesInsideParentheses: 0;
		numberOfArgumentsForMultiLine: 2;
		newLineBeforeFirstKeyword: false;
		numberOfSpacesInsideArray: 0;
		numberOfSpacesBeforeDotInDynamicArray: 0
]

{ #category : #configurations }
BIEnlumineurArrayExpressionTest >> spaceInsideArrayConfiguration [

	^ self contextClass basicNew
		formatCommentCloseToStatements: false;
		maxLineLength: 50;
		retainBlankLinesBetweenStatements: false;
		minimumNewLinesBetweenStatements: 1;
		indentStyle: #tabulation;
		indentExtraSpaces: 0;
		periodAtEndOfBlock: false;
		periodAtEndOfMethod: false;
		numberOfSpacesInsideArray: 5;
		numberOfSpacesBeforeDotInDynamicArray: 0.
		"here since we shortcut the initialize method we have to set the numberOfSpace...
		manually so that the spacesBefore string is correctly computed." 
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testEmptyArray [
	| source |
	configurationSelector := #basicConfiguration.
	source := self formatExpression: '{}'.
	self assert: source equals: '{}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testFiveSpaceAroundBrackets [
	| source |
	configurationSelector := #fiveSpacesInsideArrayConfiguration.
	source := self formatExpression: ' { 1. 2. 3 } '.
	self assert: source equals: '{     1. 2. 3     }'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testFormatElement [
	| source |
	configurationSelector := #basicConfiguration.
	source := self formatExpression: ' { a:=1. b:=2 } '.
	self assert: source equals:
'{
	(a := 1).
	(b := 2)}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testNewLineAfterBracesWhenMultiline [
	| source |
	configurationSelector := #multiLineConfiguration.
	source := self formatExpression: '{(self + (1 @ 0)).
	(self + (1 @ 1)).
	(self + (0 @ 1)).
	(self + (-1 @ 1)).
	(self + (-1 @ 0)).
	(self + (-1 @ -1)).
	(self + (0 @ -1)).
	(self + (1 @ -1))}'.
	self
		assert: source
		equals:
'{
	(self + (1 @ 0)).
	(self + (1 @ 1)).
	(self + (0 @ 1)).
	(self + (-1 @ 1)).
	(self + (-1 @ 0)).
	(self + (-1 @ -1)).
	(self + (0 @ -1)).
	(self + (1 @ -1))}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testNoExtraSpaceAroundPeriod [
	| source |
	configurationSelector := #basicConfiguration.
	source := self formatExpression: '{1.    2.        3}'.
	self assert: source equals: '{1. 2. 3}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testNoSpaceAroundBrackets [
	| source |
	configurationSelector := #basicConfiguration.
	source := self formatExpression: ' { 1. 2. 3 } '.
	self assert: source equals: '{1. 2. 3}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testOneSpaceAroundBrackets [
	| source |
	configurationSelector := #oneSpaceInsideArrayConfiguration.
	source := self formatExpression: ' { 1. 2. 3 } '.
	self assert: source equals: '{ 1. 2. 3 }'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testPeriodAtEndOfMethod [
	| source |
	configurationSelector := #periodAtEndOfMethod.
	source := self formatExpression: '{1 factorial}'.
	self assert: source equals: '{1 factorial}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testPeriodAtEndOfMethodWithMultipleElementArrayShouldNotHavePeriodAtEnd [
	| source |
	configurationSelector := #periodAtEndOfMethod.
	source := self formatExpression: '{ a := 2 . a := 2 }'.
	self assert: source equals:  '{
	(a := 2).
	(a := 2)}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testPeriodAtEndOfMethodWithMultipleElementArrayShouldNotHavePointAtTheEnd [
	| source |
	configurationSelector := #periodAtEndOfMethod.
	source := self formatExpression: '{1 factorial . 3 + 2}'.
	self assert: source equals: 
 '{
	1 factorial.
	(3 + 2)}' "we should not have a point at the end."	
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testSpaceAroundPeriod [
	| source |
	configurationSelector := #basicConfiguration.
	source := self formatExpression: '{1. 2. 3}'.
	self assert: source equals: '{1. 2. 3}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testSpaceBeforePeriod [
	| source |
	configurationSelector := #basicConfiguration.
	source := self formatExpression: '{1 . 2 . 3}'.
	self assert: source equals: '{1. 2. 3}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testSpaceInside [
	| source |
	configurationSelector := #spaceInsideArrayConfiguration.
	source := self formatExpression: ' { 1. 2. 3 } '.
	self assert: source equals: '{     1. 2. 3     }'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testThreeSpacesBeforePeriod [
	| source |
	configurationSelector := #threeSpacesBeforeDotInArrayConfiguration.
	source := self formatExpression: '{1. 2. 3}'.
	self assert: source equals: '{1   . 2   . 3}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testToLongNewLine [
	| source |
	configurationSelector := #maxLineLengthConfiguration.
	source := self formatExpression: '{VeryLongExpression. 1}'.
	self
		assert: source
		equals:
'{
	VeryLongExpression.
	1}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testToLongNewLine2 [
	| source |
	configurationSelector := #maxLineLengthConfiguration.
	source := self formatExpression: '{1. 2. 3. 4. 5. 6. 7. 1}'.
	self
		assert: source
		equals:
			'{1. 2. 3. 4.
5. 6. 7. 1}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testToLongNewLine2WithSpaceBefore [
	| source |
	configurationSelector := #maxLineLengthConfigurationWithSpaceBefore.
	source := self formatExpression: '{1. 2. 3. 4. 5. 6. 7. 1}'.
	self
		assert: source
		equals:
			'{1 . 2 . 3 . 4 .
5 . 6 . 7 . 1}'
]

{ #category : #test }
BIEnlumineurArrayExpressionTest >> testToLongNewLineWithSpaceBefore [
	| source |
	configurationSelector := #maxLineLengthConfigurationWithSpaceBefore.
	source := self formatExpression: '{VeryLongExpression. 1}'.
	self
		assert: source
		equals:
'{
	VeryLongExpression .
	1}'
]

{ #category : #configurations }
BIEnlumineurArrayExpressionTest >> threeSpacesBeforeDotInArrayConfiguration [

	^ self contextClass basicNew
		formatCommentCloseToStatements: false;
		maxLineLength: 50;
		numberOfSpacesInsideParentheses: 0;
		retainBlankLinesBetweenStatements: false;
		minimumNewLinesBetweenStatements: 1;
		indentStyle: #tabulation;
		indentExtraSpaces: 0;
		periodAtEndOfBlock: false;
		periodAtEndOfMethod: false;
		numberOfSpacesInsideArray: 0;
		numberOfSpacesBeforeDotInDynamicArray: 3
]
