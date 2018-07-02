set print pretty on
set print array on
set print array-indexes on
set print elements 10

define imagedump
    set logging overwrite on
    set logging redirect on
    set logging on $arg1
    printf "%s\n%d %d\n%d\n", $arg0, $arg3, $arg4, $arg5
    set logging off

    if $argc == 6
        append binary memory $arg1 $arg2 $arg2 + $arg3 * $arg4
    else
        append binary memory $arg1 $arg2 $arg2 + $arg6 * $arg3 * $arg4
    end
end

document imagedump
Dump raw data as ppm image. Format:
    imagedump <ppm signature> <filename> <address> <width> <height> <max value> [<factor>]
It will write image of <ppm signature> to <filename> from <address> with dimensions <width>x<height>
where pixels are restricted by <max value>. Optionally it takes scale <factor> (used by RGB).
end

define dump pgm
    set var $maxvalue = 255
    if $argc == 5
        set var $maxvalue = $arg4
    end
    set var $factor = 1
    if $maxvalue > 255
        set var $factor = 2
    end
    imagedump "P5" $arg0 $arg1 $arg2 $arg3 $maxvalue $factor
end

document dump pgm
Dump raw data as pgm image. Format:
    dump pgm <filename> <address> <width> <height> [<max pixel value>]
It will write pgm image to <filename> from <address> by <width>x<height>.
Optional value of <max pixel value> can be passed.
end

define dump ppm
    set var $maxvalue = 255
    if $argc == 5
        set var $maxvalue = $arg4
    end
    imagedump "P6" $arg0 $arg1 $arg2 $arg3 $maxvalue 3
end

document dump ppm
Dump raw data as ppm RGB image. Format:
    imagedump_rgb <filename> <address> <width> <height> [<max pixel value>]
It will write ppm image to <filename> from <address> by <width>x<height>.
Optional value of <max pixel value> can be passed.
end
