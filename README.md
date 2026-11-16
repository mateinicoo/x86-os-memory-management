# Low-Level OS Memory & File System Management Simulator (x86 Assembly)

A 32-bit x86 Assembly implementation (AT&T syntax) simulating core Operating System storage management operations. Designed for Linux systems, this application models both **1D (linear array)** and **2D (matrix grid)** continuous block allocation, deallocation, address translation, and dynamic memory defragmentation.

Developed as part of the *Computer Architecture (ASC)* curriculum at the Faculty of Mathematics and Computer Science, University of Bucharest.

---

## Technical Highlights & Key Features

- **Low-Level Architecture**: Written in pure x86 Assembly, interfacing directly with standard C library functions (`printf`, `scanf`, `fflush`) via the `cdecl` calling convention and Linux system calls.
- **First-Fit Allocation Algorithm**: Implements contiguous allocation logic. File sizes in kilobytes are dynamically converted to 8kB storage blocks using ceiling division (`(size + 7) / 8`).
- **1D & 2D Storage Models**:
  - **1D Storage**: Models an 8MB total memory space partitioned into 1,024 blocks of 8kB each.
  - **2D Storage Grid**: Models a 255 × 1,024 block matrix with row-wise contiguous layout constraints.
- **Dynamic Defragmentation**: Implements two-pointer compaction algorithms that eliminate internal/external fragmentation by shifting all allocated blocks to contiguous low-address blocks while preserving relative order.
- **Coordinate Translation**: Mathematical mapping between linear block offsets and 2D matrix coordinates `(Row, Column)` using integer division and modulo primitives (`divl`).

---

## Supported Operations

| Op Code | Operation | Description |
| :---: | :--- | :--- |
| **1** | `ADD` | Allocates continuous blocks for $N$ files using First-Fit search. Returns block range `(start, end)` or `((startX, startY), (endX, endY))`. |
| **2** | `GET` | Queries file location by File ID (1–255). Returns bound coordinates or `(0,0)` if absent. |
| **3** | `DELETE` | Removes target File ID, zeros memory blocks, and prints updated storage layout. |
| **4** | `DEFRAG` | Compacts all stored files towards lower addresses and displays updated layout. |
