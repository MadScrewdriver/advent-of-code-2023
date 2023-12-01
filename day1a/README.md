## Build
Install gcc4.9 with multilib support (for 32-bit binaries):
```
    yay -S gcc49-multilib
```

Build using cmake and gcc4.9:
```
    mkdir build
    cd build
    CC=gcc-4.9 CXX=g++-4.9 cmake ..
    make
```

Run:
```
    ./advent_of_code_2023
```