int *x, *y;
int a[5];

BEGIN
{
    // will trace 0 because global-declared variables are initialised with 0
    trace(x);

    // will trace 4
    trace(x+1);

    // will trace 8
    trace(x+2);

    x = &a[0];
    y = &a[2];

    // will trace 2
    trace(y - x);
}