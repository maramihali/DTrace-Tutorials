

/**
 * Example of using speculation in DTrace to highlight an entire code
 * path when the system call open(2) fails.
 */

 syscall::open:entry
 {
     // create a new speculation
     // if this fails detrace will generate an error message indicating the reason
     // but subsequent calls are going to be discarded (silently!)
     self->spec = speculation();
     speculate(self->spec);

     // printf speculatively traced because it follows speculate()
     // will appear in the buffer iff the speculation is committed
     printf("%s", stringof(copyinstr(arg0)));
 }

 fbt:::
 /self->spec/
 {
     // speculates the default action since there is nothing else i.e. trace the EPID
     speculate(self->spec);
 }

 // make sure that everything that has an entry also has a return
 syscall::open:return
 /self->spec/
 {
     speculate(self->spec);
     trace(errno);
 }

// commit the speculation if errno is not 0, i.e. an error occurred
syscall::open:return
/self->spec && errno != 0/
{
    // this is how you commit a speculative buffer i.e. copy it to the principal buffer
    commit(self->spec);

    // we've committed so now we clear the buffer
    self->spec = 0; 
}

// discard the speculation if no error ocurred
syscall::open:return
/self->spec && errno == 0/
{
    discard(self->spec);
    self->spec = 0;
}