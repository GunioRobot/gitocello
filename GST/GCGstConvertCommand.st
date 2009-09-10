Object subclass: GCGstConvertCommand [
    
    <category: 'Gitocello-GST'>
    <comment: 'I am used for converting a Squeak source file to Gnu Smalltalk syntax using the gst-convert tool with the options found at http://smalltalk.gnu.org/faq/169'>

    GCGstConvertCommand class >> commandLine [
	"see http://smalltalk.gnu.org/faq/169 for info on this command-line"

	<category: 'literals'>
	^(('gst-convert -f squeak
		-r''Float->FloatD''
		-r''BlockContext->BlockClosure''
		-r''MessageSend->DirectedMessage''
		-r''DateAndTime->DateTime''
		-r''TimeStamp current->DateTime now''
		-r''TimeStamp->DateTime''
		-r''ProtoObject->nil''
		-r''UnhandledError->SystemExceptions.UnhandledException''
		-r''Date current->Date today''
		-r''(``@object and: ``@arg1 and: ``@arg2 )->
		   ((``@object and: ``@arg1) and: ``@arg2)''
		-r''(``@object ifNil: ``@arg ifNotNil: [ | `@t2 | `@.s2 ] )->
		   (``@object ifNil: ``@arg ifNotNil: [ :foo || `@t2 | `@.s2 ])''
		-r''(``@object ifNotNil: [ | `@t2 | `@.s2 ] ifNil: ``@arg )->
		   (``@object ifNotNil: [ :foo || `@t2 | `@.s2 ] ifNil: ``@arg)''
		-r''(``@object ifNotNil: [ | `@t2 | `@.s2 ] )->
		   (``@object ifNotNil: [ :foo || `@t2 | `@.s2 ])''
		-r''(``@object ifNil: ``@arg1 ifNotNilDo: ``@arg2 )->
		   (``@object ifNil: ``@arg1 ifNotNil: ``@arg2)''
		-r''(``@object ifNotNilDo: ``@arg2 ifNil: ``@arg1 )->
		   (``@object ifNotNil: ``@arg2 ifNil: ``@arg1)''
		-r''(``@object ifNotNilDo: ``@arg2 )->
		   (``@object ifNotNil: ``@arg2)''
		-r''(``@object doIfNotNil: ``@arg2 )->
		   (``@object ifNotNil: ``@arg2)''
		-r''(``@object newFrom: ``@arg2 )->
		   (``@object from: ``@arg2)''
		-r''(Dictionary withAll: ``@arg2 )->
		   (Dictionary from: ``@arg2)''
		-r''(``@object evaluateWithArguments: ``@arg2 )->
		   (``@object valueWithArguments: ``@arg2)''
		-r''(``@object beginsWith: ``@arg2 )->
		   (``@object startsWith: ``@arg2)''
		-r''(``@object allSubInstancesDo: ``@arg2 )->
		   (``@object allSubinstancesDo: ``@arg2)''
		-r''(``@object directoryNamed: ``@arg2 )->
		   (``@object / ``@arg2)''
		-r''(``@object fileExists: ``@arg2 )->
		   (``@object includes: ``@arg2)''
		-r''(``@object readOnlyFileNamed: ``@arg2 )->
		   (``@object / ``@arg2) readStream''
		-r''(``@object forceNewFileNamed: ``@arg2 )->
		   (``@object / ``@arg2) writeStream''
		-r''(``@object caseInsensitiveLessOrEqual: ``@arg2 )->
		   (``@object <= ``@arg2)''
		-r''(``@object isZero)->
		   (``@object = 0)''
		-r''(``@object recursiveDelete)->
		   (``@object all remove)''
		-r''(``@object containingDirectory)->
		   (``@object parent)''
		-r''(FileDirectory default)->
		   (Directory working)''
		-r''(``@arg2 assureExistence)->

		   (``@arg2 createDirectories)''
		-r''(FileDirectory on: ``@arg2 )->
		   (``@arg2 asFile)''' 
	    replaceAll: Character lf
	    with: Character space) replaceAll: Character cr with: Character space) 
	    replaceAll: Character tab
	    with: Character space
    ]

    GCGstConvertCommand class >> convert: aFilepath [
	<category: 'actions'>
	| file |
	OSProcess 
	    waitForCommand: self commandLine , ' ' , aFilepath , ' ' , aFilepath 
		    , '.gst'.
	FileDirectory deleteFilePath: aFilepath.
	file := FileDirectory localNameFor: aFilepath.
	(FileDirectory forFileName: aFilepath) rename: file , '.gst' toBe: file
    ]
]
