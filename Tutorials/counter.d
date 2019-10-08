/*
 * Count off and report the number of seconds elapsed. This is a a basic example
    of a DTrace program. dtrace and profile are providers and BEGIN is a name
    associated with the probe to give it some semantic meaning.

    At runtime dTrace will create a probe that is activated at the beginnig of the 
    program and profile will create a probe that is activated when a second passes.
    Probe activation is referred to as firing.
 */

dtrace:::BEGIN
{
    i = 0;
}

profile:::tick-1sec
{
    i = i + 1;
    trace(i);
}

dtrace:::END
{
    trace(i);
}

