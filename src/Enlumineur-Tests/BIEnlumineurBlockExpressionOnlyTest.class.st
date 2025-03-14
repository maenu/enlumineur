Class {
	#name : #BIEnlumineurBlockExpressionOnlyTest,
	#superclass : #BIEnlumineurTest,
	#category : #'Enlumineur-Tests'
}

{ #category : #configuration }
BIEnlumineurBlockExpressionOnlyTest >> basicConfiguration [

	^ self contextClass basicNew
		numberOfSpacesInsideBlock:1;
		periodAtEndOfBlock:false;
		periodAtEndOfMethod: false;
		lineUpBlockBrackets:false;
		indentStyle: #tabulation;
		keepBlockInMessage:false;
		retainBlankLinesBetweenStatements:false;
		retainBlankLinesBeforeComments:false;
		minimumNewLinesBetweenStatements:1;
		multiLineMessages: Array new;
		oneLineMessages: Array new;
		numberOfArgumentsForMultiLine:5;
		indentsForKeywords:1;
		newLineBeforeFirstKeyword:false;
		formatCommentCloseToStatements:true;
		maxLineLength:50;
		useBasicCommentFormat:false;
		indentExtraSpaces:0
]

{ #category : #configuration }
BIEnlumineurBlockExpressionOnlyTest >> dontFormatCommentWithStatementConfiguration [

	^ self contextClass basicNew
		numberOfSpacesInsideBlock:1;
		periodAtEndOfBlock:false;
		periodAtEndOfMethod: false;
		lineUpBlockBrackets:false;
		indentStyle: #tabulation;
		keepBlockInMessage:false;
		retainBlankLinesBetweenStatements:false;
		minimumNewLinesBetweenStatements:1;
		multiLineMessages: Array new;
		oneLineMessages: Array new;
		numberOfArgumentsForMultiLine:5;
		indentsForKeywords:1;
		newLineBeforeFirstKeyword:false;
		formatCommentCloseToStatements:false;
		maxLineLength:50;
		retainBlankLinesBeforeComments: false;
		useBasicCommentFormat: false;
		indentExtraSpaces:0
]

{ #category : #configuration }
BIEnlumineurBlockExpressionOnlyTest >> testDontFormatCommentWithStatement2 [
	| source |
	configurationSelector := #dontFormatCommentWithStatementConfiguration.
	source := self formatExpression: '[ "aComment" 1 factorial.  2 factorial]'.
	self assert: source equals: '[ "aComment"
1 factorial.
2 factorial ]'
]

{ #category : #configuration }
BIEnlumineurBlockExpressionOnlyTest >> testNewLineAfterComment [

	| source |
	configurationSelector := #dontFormatCommentWithStatementConfiguration.
	source := self formatExpression: '["aComment"1. 2]'.
	self assert: source equals: '[ "aComment"
1.
2 ]'
]

{ #category : #configuration }
BIEnlumineurBlockExpressionOnlyTest >> testSpaceAfterComment [

	| source |
	configurationSelector := #dontFormatCommentWithStatementConfiguration.
	source := self formatExpression: '["aComment"1]'.
	self assert: source equals: '[ "aComment" 1 ]'
]

{ #category : #configuration }
BIEnlumineurBlockExpressionOnlyTest >> testformatComment [

	| source |
	configurationSelector := #dontFormatCommentWithStatementConfiguration.
	source := self formatExpression: '["  c1   " "   c2 " 2 factorial "c3"]'.
	self assert: source equals: '[ "  c1   " "   c2 " 2 factorial "c3" ]'
]
