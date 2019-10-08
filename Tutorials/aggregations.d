
//counts the number of write system calls in the system
syscall::write:entry
{
    // aggregations are globally available and can be devined as @name[ keys ] = aggfunc(args)
    @counts["write system calls"] = count();
}

// counts the number of write system calls per process
syscall::write:entry
{
    @counts[execname] = count();
}

syscall::write:entry
{
    // reminder: thread-local variable
    self->ts = timestamp;
}

// returns average time spent in write system call organised per process
syscall::write:return
/self->ts/
{
    @avg_time[execname] = avg(timestamp - self->ts);
    
    // reclaim memory so it can be used elsewhere by the thread
    self->ts = 0;
}

// return a frequency distribution of the time spent in write system call organised per process
// the graph will show how many writes returned in a timestamp between
// two power of twos
syscall::write:return
/self->ts/
{
    @q_time[execname] = quantize(timestamp - self->ts);
    
    // reclaim memory so it can be used elsewhere by the thread
    self->ts = 0;
}

// linear distribution of writes by file descriptor
syscall::write:entry
{
    // arguments are: first argument of each write call(i.e. the file descriptor),
    // lower bound, upper bound and a step
   @fds[execname] = lquantize(arg0, 0, 100, 1)
}

// monitor change in behaviour of a process executing the date command
syscall::execve:return
/execname == "date"/
{   
    // built-in val: timestamp virtualized by amount the current thread has spent running on a CPU
    // not including time spent in DTrace predicate and actions
    self->start = vtimestamp;
}

syscall:::entry
/self->start/
{
    // linear freqeuncy distribution of virtual time from process start to now
    // should take less than 10 miliseconds to complete
    @a["system calls over time"] = lquantize((vtimestamp - self->start) / 1000, 0, 10000, 100);

}

syscall::exit:entry
/self->start/
{
    self->start = 0;
}
