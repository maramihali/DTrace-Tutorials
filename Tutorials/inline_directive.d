inline string hello = "hello";
inline int number = 100 + 23;
 
 BEGIN 
 {
     trace(hello);

     // D compiler will substitute "number" with the compiled version of the expression
     trace(number);
 }

 // Cool hint: You can use all the inline directives provided by DTrace
 // because they are in a library and at compile time the D compiler includes
 // all the provided library files