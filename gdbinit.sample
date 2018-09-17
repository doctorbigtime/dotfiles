set confirm off
set verbose off
set history filename ~/.gdb_history
set history save on
set history size 10000
set history expansion on

set height 0
set width 0

set breakpoint pending on

shell test -e /home/sfortas/.gdb/coloutPipe && rm /home/sfortas/.gdb/coloutPipe 
shell mkfifo /home/sfortas/.gdb/coloutPipe 

define logging_on
    set logging redirect on
    set logging on /home/sfortas/.gdb/coloutPipe 
end

define logging_off
    set logging off
    set logging redirect off
    shell sleep 0.4s
end

define hook-backtrace
    shell cat /home/sfortas/.gdb/coloutPipe | colout "^(#)([0-9]+)\s+(0x\S+ )*(in )*(\S+) (\(.*\)) at (.*/)?(?:$|(.+?)(?:(\.[^.]*)|)):([0-9]+)" red,red,blue,none,green,cpp,none,white,white,yellow normal,normal,normal,normal,normal,normal,normal,bold,bold,normal &
    logging_on
end
define hookpost-backtrace
    logging_off
end

define threads
    info threads
end

define hook-threads
    shell cat /home/sfortas/.gdb/coloutPipe | colout "^(\*)?\s+(\S+ +)Thread (0x\S+ )\(LWP (\S+)\) (\S+) (0x\S+)?( in )?(\S+) \((.*)\) \S+ (.*/)([^:]+)?:?([0-9]+)?"  yellow,red,blue,white,white,blue,none,green,cpp,none,white,yellow  normal,bold,normal,bold,bold,normal,normal,normal,normal,normal,bold,normal &
    logging_on
end
define hookpost-threads
    logging_off
end

define pv
    if $argc != 2
        echo Usage: pv <vector> <index>\n
    end
    print *($arg0._M_impl._M_start + $arg1)
end
document pv 
    Prints an item in a std::vector
end

python
import sys
sys.path.insert(0, '/home/sfortas/.gdb/printers/python')
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
# insert other printers here...
end


