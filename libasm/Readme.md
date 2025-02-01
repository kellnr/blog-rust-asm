# Useful Information

- [Functions in ARM64](https://diveintosystems.org/book/C9-ARM64/functions.html)
- [Compiler Explorer](https://godbolt.org/) <- Set to armv8-a clang 16.0.0
- [ARM64 Calling Convention](https://duetorun.com/blog/20230615/a64-pcs-demo/#stack_layout)
- [ARM64 Calling Convention 2](https://dede.dev/posts/ARM64-Calling-Convention-Cheat-Sheet/)
- [HelloSilicon | ARM64 Assembly](https://github.com/below/HelloSilicon)
- [ARM64 Assembly Instruction Set](https://developer.arm.com/documentation/dui0489/i/arm-and-thumb-instructions?lang=en)

## Build and run

```bash
# Build executable
make # or make exe

# Build dynamic library
make dylib

# List exported symbols from dynamic library
nm -gU <dylib>
```

## Debugging with LLDB

- [LLDB Cheat Sheet](https://firexfly.com/lldb-cheatsheet/)

```bash
# Start debugging
lldb ./binary

# Set breakpoint
br set -n label

# Run program
r

# Continue execution
c

# Print register values
register read

# Print stack (8 Bytes per column, 24 columns)
x -s8 -fx -c24 $sp

# Disassemble
disassemble -n label

# Single step (into)
si

# Single step (over)
ni
```
