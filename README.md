# cpm_baseArchive
cpm base archives and its generator

# Build time

| build target | environment | build time |
| ---------- | ---- | ---- |
| gcc-8.4.0 | 8 core, 32 GB, Ubuntu 18.04 LTS | 70 mins |

Note. Building gcc may require a lot of memory. Using 32 or 64 GB RAM machine and adding a swap memory as insurance.

# Build and generate a local gcc archive
Execute below commands
```
./build_gcc-8.4.0.sh
./gen_base_archive_gcc-8.4.0.sh
```

# File and Directory descriptions

| File or directory name        | Description Origin |
| ----------------------------- | ------------------ |
| base_archive/                 | Archived files of builded gcc |
| docker/                       | Dockerfile and the other required files to build gcc on Ubuntu 18.04 with gcc 7.5.0 |
| docs/                         | Documentation files |
| env_cpm/                      | Tmporary direcotry for build gcc |
| env_cpm/build                 | Temporary directory for build |
| env_cpm/cache                 | Cache files of build taegaets |
| env_cpm/local                 | Destination direcotry to save the builded files |
| src/                          | Build scripts |
| .git                          | git files |
| README.md                     | This file |
| build_gcc-8.4.0.sh            | Building gcc-8.4.0 on docker container |
| clean.sh                      | Removing temporary file and direcotries |
| gen_base_archive_gcc-8.4.0.sh | Converting builded gcc files at `enc_cpm` and generating base archive files |
| main.c                        | File for tests |
| main.cpp                      | File for tests |
| run_test.sh                   | Running the compilation tests |
| .gitignore                    | Registering files to ignore in order not to track files on git |

