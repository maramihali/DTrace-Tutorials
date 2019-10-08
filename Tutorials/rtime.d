/*
    Example of thread-local variable usage. Storage is not assigned to them
    until a non-zero value is assigned to it. They are kept in a separate namespace
    from globar variables (yay!)
*/

// declaration of thread local variable
self int x; 

syscall::read:entry
{
    self->x = 123
    trace(x);
}

syscall::read:entry
{
    // thread-local vairable i.e. local to each operating system thread
    self->t = timestamp;            
}

syscall::read:return
/self->t != 0/
{   
    //prints the time spent in read
    printf("%s/%d spent %d nsecs in read(2)\n", execname, tid, timestamp - self->t);
    
    /* Assign 0 to thread-local variable to allow the DTrace runtime to reclaim the storage
       for the associated thread
     */
    self->t = 0;
}

