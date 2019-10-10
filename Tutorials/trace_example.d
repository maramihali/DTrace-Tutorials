
// basic examples of the trace action
// trace takes a D expr as arg and traces the result to the directed buffer (?)
BEGIN
{   
    // process name
    trace(execname);

    // priority of the lightweight process
    // lwp make multitasking doable at user level˚
    trace(curlwpsinfo->pr_pri);

    //this two can be neatly formatted like
    printf("execname is %s; priority is %d", execname, curlwpsinfo->pr_pri);

    trace(timestamp / 1000); 

    trace("somehow managed to get here");

}