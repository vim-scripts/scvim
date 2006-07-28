TestCase Unit Testing


Rather than write full classes that test each method of your class, this uses a simple instance.

TestCase(Object,
 '==' -> {
 var a;
 a = Object.new;
 a == a // test passes if it returns true
 }
);

TestCases for each class can be stored in "TestingAndToDo/Tests" as Classname.test.rtf (note that if you check "hide extension" it will just say Classname.test).

Any class can find and run its test:

 Float.test;
 
If not found, a message is posted.

All classes can try and run their tests if they have them:

 TestCase.runAll;
 
An individual test case that you are working on can be run:

TestCase(Object,
 '!==' -> {
 var a;
 a = Object.new;
 a !== a // a deliberate failure
 }
 ).run;

You can click to open the class file or the test file.

