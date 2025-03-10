Class {
	#name : #BISettingPreviewerTest,
	#superclass : #TestCase,
	#instVars : [
		'biSettingPreviewer'
	],
	#category : #'EnlumineurUI-Tests'
}

{ #category : #tests }
BISettingPreviewerTest >> selectClassNamed: aName fromUI:biChooseMethod [
	biChooseMethod classList
		selectIndex:
			(biChooseMethod classList items
				indexOf:
					(biChooseMethod classList items
						detect:
							[ :class | class name = aName ]))
]

{ #category : #tests }
BISettingPreviewerTest >> selectPackageNamed: aName fromUI: biChooseMethod [
	biChooseMethod packageList
		selectIndex:
			(biChooseMethod packageList items
				indexOf:
					(biChooseMethod packageList items
						detect:
							[ :package | package name = aName ]))
]

{ #category : #running }
BISettingPreviewerTest >> setUp [
    biSettingPreviewer := BISettingPreviewer2 new.
    biSettingPreviewer methodProvider: BIForTestMethodProvider
]

{ #category : #running }
BISettingPreviewerTest >> tearDown [ 
	biSettingPreviewer delete.
	biSettingPreviewer application close.
	super tearDown
]

{ #category : #tests }
BISettingPreviewerTest >> testChangingMethodProvider [
    biSettingPreviewer methodProvider: BIForTestMethodProvider.
    self
        assertCollection:
            (BIForTestMethodProvider methods
                select: [ :method | method category = 'methods' ])
        hasSameElements: biSettingPreviewer methodDropList listItems.
    self
        assertCollection:
            (BIForTestMethodProvider class methods
                select: [ :method | method category = 'settings' ])
        hasSameElements: biSettingPreviewer settingsDropList listItems.

]

{ #category : #tests }
BISettingPreviewerTest >> testClickChooseMethodButtonAndAcceptWithNotNilMethodShouldFillBeforePrettyPrinterCodePresenter [
	| chooseMethodUI |
	chooseMethodUI := SpChooseMethodUI new.
	self
		selectPackageNamed: BIUseForTestWithMethod package name
		fromUI: chooseMethodUI.
	self
		selectClassNamed: BIUseForTestWithMethod name
		fromUI: chooseMethodUI.
	biSettingPreviewer acceptActionBIChooseMethod: chooseMethodUI.
	self
		assert: biSettingPreviewer notFormatedTextPresenter text
		equals: chooseMethodUI methodList selection selectedItem sourceCode
]

{ #category : #tests }
BISettingPreviewerTest >> testClickOnRemoveMethodButtonShouldRemoveTheFromMethodDropList [
	[ BIForTestMethodProvider  
		compile: 'myMethodTestazert ' , String cr , '^ klm'.
		(BIForTestMethodProvider   >> #myMethodTestazert) protocol: 'methods'.
	biSettingPreviewer methodDropList
		selectedIndex:
			(biSettingPreviewer methodDropList listItems indexOf: (BIForTestMethodProvider>>#myMethodTestazert)).
	biSettingPreviewer removeMethodButton click.
	self
		deny:
			(biSettingPreviewer methodDropList listItems
				contains: [ :item | item selector = #myMethodTestazert ]) ]
		ensure: [ [ 
				(BIForTestMethodProvider >> #myMethodTestazert) removeFromSystem ]
				on: KeyNotFound
				do: [  ] ]
]

{ #category : #tests }
BISettingPreviewerTest >> testClickOnSaveMethodButtonShouldAddToMethodDropListAndToTheMethodProviderClass [
	[ 
	biSettingPreviewer notFormatedTextPresenter
		text: 'myMethodTestazert ' , String cr , '^ klm'.
	biSettingPreviewer saveMethodButton click.
	self
		assert:
			(biSettingPreviewer methodDropList listItems
				anySatisfy: [ :item | item selector = #myMethodTestazert ]).
	self
		assert: (BIForTestMethodProvider >> #myMethodTestazert) category
		equals: 'methods' ]
		ensure: [ [ (BIForTestMethodProvider >> #myMethodTestazert) removeFromSystem ]
				on: KeyNotFound
				do: [ self fail ] ]
]

{ #category : #initialization }
BISettingPreviewerTest >> testDropListSelectedIndexShouldBeEqualsToOne [
	self assert: biSettingPreviewer methodDropList selectedIndex equals: 1.
]

{ #category : #initialization }
BISettingPreviewerTest >> testInitializeAfterPrettyShouldFillWithTheSelectedItemOfDropListPresenter [
	self
		assert: biSettingPreviewer formatedTextPresenter text
		equals: (biSettingPreviewer formaterPrettyPrinter format: biSettingPreviewer  methodDropList selectedItem ast)
]

{ #category : #initialization }
BISettingPreviewerTest >> testInitializeBeforePrettyShouldFillWithTheSelectedItemOfDropListPresenter [
	self
		assert: biSettingPreviewer notFormatedTextPresenter text
		equals: biSettingPreviewer methodDropList selectedItem sourceCode
]

{ #category : #tests }
BISettingPreviewerTest >> testWhenAddNewWithSameAsAnOhterOneShouldRemoveTheOldOneFromTheSettingDropList [
	[| codePresenterUI |
	codePresenterUI := BIInputPresenterUI openOn: biSettingPreviewer.
	codePresenterUI presenter codePresenter text: 'testSameNameSetting'.
	codePresenterUI triggerOkAction.
	codePresenterUI := BIInputPresenterUI openOn: biSettingPreviewer.
	codePresenterUI presenter codePresenter text: 'testSameNameSetting'.
	codePresenterUI triggerOkAction.
	self
		assert:
			(biSettingPreviewer settingsDropList listItems
				count:
					[ :settingCompiledMethod | settingCompiledMethod selector = #testSameNameSetting ])
		equals: 1]ensure: [(BIForTestMethodProvider class >>#testSameNameSetting) removeFromSystem]

]

{ #category : #tests }
BISettingPreviewerTest >> testWhenAddingAMethodMethodDropListYouldBeSetAtTheNewMethod [
    [biSettingPreviewer notFormatedTextPresenter
        text:
            'xmyTestMethodItWillBeRemoveAtTheEndOfThisTest' , String cr
                , '^ ''klmùklmklmklmkmlkmkmlkmkmlkkmlkml'''.
	biSettingPreviewer saveMethodButton click.
	self assert: biSettingPreviewer methodDropList selectedItem selector 
	equals: #xmyTestMethodItWillBeRemoveAtTheEndOfThisTest ] ensure: [ (biSettingPreviewer methodProvider >> #xmyTestMethodItWillBeRemoveAtTheEndOfThisTest ) removeFromSystem ]
]

{ #category : #tests }
BISettingPreviewerTest >> testWhenAddingAStteingSettingDropListShouldBeSetAtTheNewMethod [
    [| codePresenterUI |
	codePresenterUI := BIInputPresenterUI openOn: biSettingPreviewer.
	codePresenterUI presenter codePresenter text: 'xtestAddingASetting'.
	codePresenterUI triggerOkAction.
	self assert: biSettingPreviewer settingsDropList selectedItem selector equals: #xtestAddingASetting]
	ensure: [ (biSettingPreviewer methodProvider  class >> #xtestAddingASetting) removeFromSystem ]
]

{ #category : #initialization }
BISettingPreviewerTest >> testWhenClickOnRemoveSettingButtonShouldRemoveItFromSettingDropListAndFromProvideMethodClass [
    [ | stream |
    stream := ReadWriteStream with: OrderedCollection new.
    stream
        nextPut: 'testConfigRemoveSettingTest';
        nextPut: String cr;
        nextPut: '^ '.
    biSettingPreviewer methodProvider contentRemovable storeOn: stream.
    biSettingPreviewer methodProvider class
        compile: ('' join: stream contents).
    BIForTestMethodProvider class >> #testConfigRemoveSettingTest
        protocol: 'settings'.
    biSettingPreviewer settingsDropList
        items:
            (biSettingPreviewer methodProvider class methods
                select: [ :method | 
                    method protocol = #settings ]) asOrderedCollection.
    biSettingPreviewer settingsDropList
        selectedIndex:
            (biSettingPreviewer settingsDropList listItems
                indexOf: BIForTestMethodProvider class >> #testConfigRemoveSettingTest).
    biSettingPreviewer removeSettingButton click.
    self
        deny:
            (biSettingPreviewer settingsDropList listItems
                anySatisfy: [ :item | item selector = #testConfigRemoveSettingTest ]).
    self
        deny:
            (BIForTestMethodProvider class methods
                anySatisfy: [ :item | item selector = #testConfigRemoveSettingTest ]) ]
        ensure: [ [ (BIForTestMethodProvider class >> #testConfigRemoveSettingTest)
                removeFromSystem ]
                on: KeyNotFound
                do: [  ] ]
]

{ #category : #initialization }
BISettingPreviewerTest >> testWhenClickOnSaveSettingButtonShouldCreateMethodClassSideWithProcolSettingsAndAddToSettingsDropList [
	| codePresenterUI |
	[ codePresenterUI := BIInputPresenterUI openOn: biSettingPreviewer.
	codePresenterUI presenter codePresenter text: 'myConfigTest'.
	codePresenterUI triggerOkAction.
	self
		assert: [ biSettingPreviewer settingsDropList listItems
				anySatisfy: [ :item | item selector = #myConfigTest ] ].
	self
		assert:
			(biSettingPreviewer methodProvider class methods
				anySatisfy: [ :item | item selector = #myConfigTest ]) ]
		ensure: [ (biSettingPreviewer methodProvider class >> #myConfigTest)
				removeFromSystem.
				 ]
]

{ #category : #tests }
BISettingPreviewerTest >> testWhenDropListSelectionChangedShouldBeforePrettyContainTheSelectedMethod [
	biSettingPreviewer methodDropList selectedIndex: 2.
	self assert: biSettingPreviewer notFormatedTextPresenter text 
	equals: biSettingPreviewer methodDropList selectedItem sourceCode
]

{ #category : #tests }
BISettingPreviewerTest >> testWhenSaveAMethodShouldBeInstanceSide [
	[ 
	biSettingPreviewer notFormatedTextPresenter
		text: 'myMethodTestazert ' , String  cr , '^ klm'.
	biSettingPreviewer saveMethodButton click ]
		ensure: [ [ (BIForTestMethodProvider >> #myMethodTestazert) removeFromSystem ]
				on: KeyNotFound
				do: [ self fail ] ]
]

{ #category : #tests }
BISettingPreviewerTest >> testWhenSaveAModifiedMethodShouldAppearOnlyOnceInMethodPrivider [
	[ | lastCompileMethod |
	lastCompileMethod := biSettingPreviewer methodDropList listItems
		at:
			(biSettingPreviewer methodDropList listItems
				indexOf: BIForTestMethodProvider >> #useForTestWillBeModified).
	BIForTestMethodProvider
		compile:
			'useForTestWillBeModified ' , String cr
				, '^ ''what i have in my hat ? a banana'''.
	self
		assert:
			(biSettingPreviewer methodDropList listItems
				count:
					[ :compiledMethod | compiledMethod selector = #useForTestWillBeModified ])
		equals: 1.
	self
		deny: BIForTestMethodProvider >> #useForTestWillBeModified = lastCompileMethod ]
		ensure: [ BIForTestMethodProvider
				compile:
					'useForTestWillBeModified ' , String cr
						, '^ ''what i have in my hat ? ''' ]
]

{ #category : #initialization }
BISettingPreviewerTest >> testWhenSettingsDropListSelectionShouldFormatedTextChanged [
    | textChanged |
	textChanged := false.
    self
        deny: biSettingPreviewer settingsDropList selectedItem selector
        equals: #testConfigIdentStringTabulation.
 	biSettingPreviewer formatedTextPresenter whenTextChangedDo: [ textChanged := true ].   
	biSettingPreviewer settingsDropList
        selectedIndex:
            (biSettingPreviewer settingsDropList listItems
                indexOf:
                    biSettingPreviewer methodProvider class
                        >> #testConfigIdentStringTabulation).
    self
        assert: textChanged
]

{ #category : #initialization }
BISettingPreviewerTest >> testWhenSettingsDropListSelectionShouldPrettyPrinterContextChanged [
	| streamA streamB |
	self
		deny: biSettingPreviewer settingsDropList selectedItem selector
		equals: #testConfigIdentStringTabulation.
	biSettingPreviewer settingsDropList
		selectedIndex:
			(biSettingPreviewer settingsDropList listItems
				indexOf:
					biSettingPreviewer methodProvider class
						>> #testConfigIdentStringTabulation).
	streamA := ReadWriteStream on: OrderedCollection new.
	streamB := ReadWriteStream on: OrderedCollection new.
	biSettingPreviewer formaterPrettyPrinter class
		defaultPrettyPrintContext storeOn: streamA.
	(STON
		fromString:
			(biSettingPreviewer settingsDropList selectedItem
				valueWithReceiver: biSettingPreviewer methodProvider
				arguments: #())) storeOn: streamB.
	self
		assert: ('' join: streamA contents)
		equals: ('' join: streamB contents)
]

{ #category : #tests }
BISettingPreviewerTest >> testWhenWeCreatAMethodInBrowserWithTheGoodTagShouldAddThisOneToMethodDropList [
	[
	BIForTestMethodProvider
		compile: 'myMethodForTestingAnnouncement' , String cr , '^ ''klmklm'' '.
	self
		assert:
			(biSettingPreviewer methodDropList listItems
				contains:  [:methodItem |methodItem selector = #myMethodForTestingAnnouncement])]
			ensure: [(BIForTestMethodProvider >>#myMethodForTestingAnnouncement ) removeFromSystem] 
]

{ #category : #tests }
BISettingPreviewerTest >> testWhenWeDelateAMethodInBrowserShouldRemoveThisOneFromMethodDropList [
	[
	(BIForTestMethodProvider >> #useForTestWillBeRemove) removeFromSystem.
	self
		deny:
			(biSettingPreviewer methodDropList listItems
				contains: [ :methodItem | methodItem selector = #useForTestWillBeRemove ])
	]
		ensure: [ | newMethod |
			newMethod := BIForTestMethodProvider
				>>
					(BIForTestMethodProvider
						compile: 'useForTestWillBeRemove' , String cr , '^ ''klmklm'' ').
			newMethod protocol: 'methods'
			]
]

{ #category : #tests }
BISettingPreviewerTest >> testWhenWeHave2MethodWithSameASTAndWeWantToremoveOneOfThemShouldRemoveTheGoodONeNotTheFirst [
    self timeLimit: 1 minutes.
    [ biSettingPreviewer methodProvider compile: 'zzzzzzx'.
    biSettingPreviewer methodProvider compile: 'zzzzzzz'.
    biSettingPreviewer methodDropList
        selectedIndex:
            ((biSettingPreviewer methodDropList listItems collect: #selector)
                indexOf: 'zzzzzzz').
    self
        assert: biSettingPreviewer methodDropList selectedItem selector
        equals: 'zzzzzzz'.
    biSettingPreviewer removeMethodButton click.
    self
        deny:
            ((biSettingPreviewer methodDropList listItems collect: #selector)
                includes: 'zzzzzzz').
    self
        assert:
            ((biSettingPreviewer methodDropList listItems collect: #selector)
                includes: 'zzzzzzx') ]
        ensure: [ (biSettingPreviewer methodProvider >> #zzzzzzx) removeFromSystem ]
]

{ #category : #tests }
BISettingPreviewerTest >> testWhenWeModifiedAMethodInBrowserShouldModifieBeforePrettyPrintTextPresenter [
	BIForTestMethodProvider
		compile:
			'useForTestWillBeModified' , String cr
				, '^ ''what i have in my hat ? A Banana'''.
	biSettingPreviewer methodDropList
		selectedIndex:
			(biSettingPreviewer methodDropList listItems
				indexOf: BIForTestMethodProvider >> #useForTestWillBeModified).
	self
		assert: biSettingPreviewer notFormatedTextPresenter text
		equals:
			'useForTestWillBeModified' , String cr
				, '^ ''what i have in my hat ? A Banana'''
]
