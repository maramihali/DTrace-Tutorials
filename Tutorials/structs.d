/** 
 * Program demoing basic struct usage 
 */

struct callinfo {
    // timestamp of last syscall entry
    uint64_t ts; 

    // total elasped time in nanoseconds
    uint64_t elapsed;

    // # calls made
    uint64_t calls;

    // max byte count argument
    size_t maxbytes;
};

// i is an associative array
struct callinfo i[string];

// inefficient clause (DTrace needs to create 3 associative arrays and storye three identical
// tuple values corresponding to probefunc for each one)

syscall::read:entry, syscall::write:entry // on function entry
/pid == $1 / //shell's pid
{
    ts1[probefunc] = timestamp;
    calls1[probefunc]++;
    maxbytes1[probefunc] = arg2 > maxbytes1[probefunc] ? arg2 : maxbytes1[probefunc];
}

// efficient clause with structs
syscall::read:entry, syscall::write:entry 
/pid == $1 / //shell's pid
{
    i[probefunc].ts = timestamp;
    i[probefunc].calls++;
    i[probefunc].maxbytes = arg2 > i[probefunc].maxbytes ? arg2 : i[probefunc].maxbytes;
}

syscall::read:return, syscall::write:return // on functions return 
/ i[probefunc].ts != 0 && pid == $1/
{
    i[probefunc].elapsed += timestamp - i[probefunc].ts;
}

END
{
    printf("        calls  max bytes  elapsed nsecs\n");
    printf("------  -----  ---------  -------------\n");
    printf("  read  %5d  %9d  %d\n", i["read"].calls, i["read"].maxbytes, i["read"].elapsed);
    printf("  write  %5d  %9d %d\n", i["write"].calls, i["write"].maxbytes, i["write"].elapsed);
}
