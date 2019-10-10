/**
 * Simple example of speculative tracing
 */

 syscall::open:entry
 {
     // returns speculative buffer ID which will be non-zero if we successfully allocated memory
     self->spec = speculation();
 }

 syscall:::
 /self->spec/
 {
     speculate(self->spec);
     printf("this is speculative");
 }

// don't forget to commit
 syscall:::return
 {
     commit(self->spec);
 }