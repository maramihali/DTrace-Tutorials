// We define associative arrays as name[key] = expression
// Space is allocated to it only when given a non-zero value

// associative array can be declared as well this is not necesary
int a[string,int,int];

dtrace:::BEGIN
{
    
    a["hello",123, 4] = 456;
    trace(a["hello",123, 4]);

}

dtrace:::END 
{
   a["hello",123, 4] ++;
   trace(a["hello",123,4]);
}