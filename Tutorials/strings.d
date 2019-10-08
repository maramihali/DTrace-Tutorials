/*
    D language provides both explicit string type and possibility of using
    char * to refer to strings.
*/

char *s1;
string s2;

dtrace:::BEGIN
{
    s1 = "hello";

    // if we didn't declare this previously as string, the D compiler will
    // still assign it type string (and add the terminating null byte automatically)
    s2 = "hello";

    // traces the value of pointer s1 (integer address value). This referes to 
    // the separate piece of storage that contains the character
    trace(s1);

    // traces the single character at dereferenced location - ASCII value
    trace(*s1);

    // DTrace knows it needs to trace a null-terminated string whose
    // address is stored at location s
    trace(s2);
}