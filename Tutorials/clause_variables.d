  /* an integer global variable
 always initialised to 0 here */
int me;

/* an integer clause-local variable, active for the lifetime of clause
and then claimed back for reuse, defineed using the special identifier this
then, they can be assigned by applying the -> operator to this */
this int foo; 

// this program will always output 10, 11, 12 because clauses are always executed 
// in same order AND clause-local vars are persistent accross different clauses
// enabling same probe

tick-1sec
{
    /*
     set foo to be 10 if this is first clause executed
    */
    this->foo = (me % 3 == 0) ? 10 : this->foo;
    printf("Clause 1 is number %d; foo is %d\n", me++ % 3, this->foo++)
}

tick-1sec
{
    /*
        set foo to be 20 if this is the first clause executed   
    */
    this->foo = (me % 3 == 0) ? 20 : this->foo;
    printf("Clause 2 is number %d; foo is %d\n", me++ % 3, this->foo++)

}

tick-1sec
{
    /*
        set foo to be 30 if this is the first clause executed   
    */
    this->foo = (me % 3 == 0) ? 30 : this->foo;
    printf("Clause 3  is number %d; foo is %d\n", me++ % 3, this->foo++)
    
}