# Description :

The purpose of this repository is to share my progress in learning x86 assembly and to showcase my motivation, with the hope of possibly working in a specific field related to this language one day.

I fully recognize that my code won’t be perfect, but I’ll make every effort to ensure it’s well-structured, thoroughly commented, and that variable names follow best practices to promote readability and understanding.

# How to Run My Exercises :

Below are three different methods to run the various assembly codes in this repository.

1. Simple Execution, Without Dynamic Linking :

To execute code in a standard way without linking to dynamic libraries :
```shell
c3lp86@asm:~/Assembler_exercise_solution_for_my_self-taught_learning/Exercise 1 - Hello World$ ../executable.sh HelloWorld.s
Hello World
```

2. Execution with Dynamic Linking to libc (for functions like printf, scanf, etc.) :

Use the **`-d`** option to enable dynamic linking with standard C libraries :
```shell
c3lp86@asm:~/Assembler_exercise_solution_for_my_self-taught_learning/Exercise 3 - Arithmetic operator$ ../executable.sh calculator.s -d
Please choose your first value : 15
Please choose your second value : 3
Here is the answer to your addition : 18
Here is the answer to your subtraction : 12
Here is the answer to your multiplication : 45
Here is the answer to your division : 5
```

3. Debug Mode Execution (Not Yet Available for Dynamically Linked Code) :

First, you need to install GDB :
```shell
sudo apt-get update
sudo apt-get install gdb -y
```

Bonus : installation of the GEF extension :
```shell
wget -O ~/.gdbinit-gef.py -q https://gef.blah.cat/py
echo source ~/.gdbinit-gef.py >> ~/.gdbinit
```

To run code in debug mode, use the **`-g`** option (this option doesn’t currently work for programs that require dynamic linking) :
```shell
c3lp86@asm:~/Assembler_exercise_solution_for_my_self-taught_learning/Exercise 1 - Hello World$ ../executable.sh HelloWorld.s -g
GEF for linux ready, type `gef' to start, `gef config' to configure
93 commands loaded and 5 functions added for GDB 15.0.50.20240403-git in 0.00ms using Python engine 3.12
Reading symbols from HelloWorld...
(No debugging symbols found in HelloWorld)
gef➤ 
```

# TO-DO :

- Modify the compiler to enable debugging for dynamically linked executables.
