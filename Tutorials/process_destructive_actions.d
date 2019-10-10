/**
 * DTrace actions can be destructive i.e. change the state of the system
 * (in a well-defined way tho!).
 * They have to be specifically enabled.
 * This is an example of process destructive actions i.e. destructive only to
 * a particular process.
 */

// allow destructive actions (-w)
 #pragma D option destructive

// output only explicitly traced data
 #pragma D option quiet

 proc:::signal-send
 /args[2] == SIGINT/ //interrupt signal sent when user presses ctrl-c
 {
     printf("SIGINT sent to %s by ", args[1]->pr_fname);
     system("getent passwd %d | cut -d: -f5", uid);

 }