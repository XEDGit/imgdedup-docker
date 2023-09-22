## Dedupping

### Usage

You need a .zip archive (or a folder) with pictires to deduplicate inside  
From now on we will call it archive

To try running the process on host computer run this command in the terminal

```shell
$ ./setup.sh /path/to/archive.zip
```

In case it doesn't work, try running the docker script.

Then, use the Docker Desktop application to run it or run this command in the terminal
```shell
$ ./docker-setup.sh
```

### Result:

All the results will be found in the folder **./output/**

- The deduplicated pictures are gonna be inside the folder named *archivename_dedup/archive_N*

This system is designed to preserve and compare different outputs of the program on the same archive
