/*
    Example of probe name pattern matching. This will trace
    a timestamp every time probes associated with entry to syscall
    matching "sock" fire
*/
syscall::*sock*:entry
{
    trace(timestamp);   
}
