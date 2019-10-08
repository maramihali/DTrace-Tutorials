BEGIN
{
    // NULL is a special invalid pointer value which is a built-in alias for address o
    // addres o, by convention, is always definied to be invalid so NULL can be sentinel
    // value in C and D programs
    // here we want to cast NULL to a pointer to integer
    x = (int *)NULL;

    // then, we dereference x and assign result to y
    // this will fail in execution due to invalid pointer access
    y = *x;
    trace(y);
}