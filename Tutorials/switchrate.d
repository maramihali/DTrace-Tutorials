// see the delay inherent in the system by tuning the switchrate
// switchrate is the default buffer processing rate given by the default buffering policy
// also an example of process destructive action because of system()

#pragma D option quiet
#pragma D option destructive

//tune switchrate in option
// this is for the principal buffer (printf, trace, unstack, etc..) allocated per-CPU
// it has a switch buffer policy i.e. there is a pair of buffers allocated per CPU: active and inactive
// DTrace consumer attempts to read bufer => kernel switches inactive with active
// done so there is no tracing window when data is lost (if we have no space to store tracing data DTrace will drop it)
// inactive buffer copied to consumer, active buffer traced
// rate at which buffer is switched  tunable via switchrate
#pragma D option switchrate=5sec

tick-1sec
/n++ < 5/
{
    // curr # of nanosecs since 00:00 UTC, Jan 1, 1970
    printf("walltime : %Y\n", walltimestamp);
    printf("date      : ");
    // note: execution of date command occured when buffer processed (?) NOT when sys command is recorded
    system("date");
    printf("\n");
}

tick-1sec
/ n == 5/
{
    exit(0);
}