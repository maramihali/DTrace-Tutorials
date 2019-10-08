/**
 * Enum examples with the note that DTrace provides
 * access to enums defined in os kernel and loadable modules
 * i.e. enum uio_rw { UIO_READ, UIO_ WRITE} for function
 * uiomove() - device driver I/O routines
 */

// enumerator that are not visible in a DTrace program can be promoted
// to global visibility by comparison as demonstrated below
 fbt::uiomove:entry
 /args[2] == UIO_WRITE/
 {
     // insert wanted tracing here
 }