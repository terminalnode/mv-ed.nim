## Similar to `&=`, but adds a newline after the string.
proc `&&=`*(
    s: var string,
    a: string,
) = s.add(a & "\n")
