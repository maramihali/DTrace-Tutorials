/**
 * Example of using the normalize function: normalize(aggr_fun, norm_factor)
 * to print data.
 */

 #pragma D option quiet

 BEGIN
 {
     //start time in nanoseconds
     start = timestamp;
     last = timestamp;
 }

 syscall:::entry
 {
    @func[execname] = count();
     @ten_seconds[execname] = count();
 }

//show system call rate only for the most recent ten-second period
 tick-10sec
 {   printf("-------- MOST RECENT TEN-SECOND PERIOD --------");
     
     //show per second system call rate of only the top ten system-calling apps
     // using truncation
     trunc(@ten_seconds, 10);

     normalize(@ten_seconds, (timestamp - last) / 1000000000);
     printa(@ten_seconds);
     clear(@ten_seconds);
     last = timestamp;
     
     printf("-------- END OF MOST RECENT TEN-SECOND PERIOD --------");

 }

 END
 {
     this->seconds = (timestamp - start) / 1000000000;

    printf("Ran for %d seconds.\n", this->seconds);
    
    printf("Per-second rate:\n");
     // Normalize aggregation based on number of seconds spent running the script
    normalize(@func, this->seconds);
    printa(@func);
    
    printf("\nRaw counts:\n");
    denormalize(@func);

    // prints the snapshot of aggregation data from the denormalized aggregated function
    printa(@func);
 }