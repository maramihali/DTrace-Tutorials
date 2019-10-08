/*
    D program that demos the use of predicates. Predicates are evaluated at
    firing time to determine whether associated actions should be executed.
    The action statements reside between braces, separated by ;.
*/
dtrace:::BEGIN
{
    i = 10;
}

profile:::tick-1sec
/i > 0/ /* this is a predicate*/
{
    trace(i--);
}

profile:::tick-1sec
/i == 0/
{
    trace("blastoff");
    exit(0);
}