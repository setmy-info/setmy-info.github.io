# Tar

## Information

## Installation

### Rocky Linux

### Fedora

### FreeBSD

### OpenIndiana

## Configuration

## Usage, tips and tricks

Pack

    tar cvf  ./foo.tar     ./foo
    tar cvzf ./foo.tar.gz  ./foo
    tar cvjf ./foo.tar.bz2 ./foo
    tar cvJf ./foo.tar.xz  ./foo
    tar cvZf ./foo.tar.Z   ./foo
    tar cvf - ./foo | lzip > ./foo.tar.lz
    # or
    tar cvf  ./foo.tar ./foo && lzip ./foo.tar

Packaging directory content into root inside package

    tar cvf  ./foo.tar -C /path/to/parent/directory     foo
    tar cvzf ./foo.tar.gz  -C /path/to/parent/directory foo
    tar cvjf ./foo.tar.bz2 -C /path/to/parent/directory foo
    tar cvJf ./foo.tar.xz  -C /path/to/parent/directory foo
    tar cvZf ./foo.tar.Z   -C /path/to/parent/directory foo

Extract

    tar xvf  ./foo.tar
    tar xvzf ./foo.tar.gz
    tar xvjf ./foo.tar.bz2
    tar xvJf ./foo.tar.xz
    tar xvZf ./foo.tar.Z
    lzip -d foo.tar.lz && tar xvf foo.tar

Extract to specific folder:

    tar xvf  ./foo.tar     -C /path/to/extract/directory
    tar xvzf ./foo.tar.gz  -C /path/to/extract/directory
    tar xvjf ./foo.tar.bz2 -C /path/to/extract/directory
    tar xvJf ./foo.tar.xz  -C /path/to/extract/directory
    tar xvZf ./foo.tar.Z   -C /path/to/extract/directory
    lzip -d  ./foo.tar.lz && tar xvf ./foo.tar -C /path/to/extract/directory

View
    
    tar tvf  ./foo.tar
    tar tvzf ./foo.tar.gz
    tar tvjf ./foo.tar.bz2
    tar tvJf ./foo.tar.xz
    tar tvZf ./foo.tar.Z
    lzip -d  ./foo.tar.lz && tar tvf  ./foo.tar

.tar.gz	Tarball compressed with gzip.	.tgz (shorter variant)
.tar.bz2	Tarball compressed with bzip2.	.tbz, .tbz2
.tar.xz	Tarball compressed with xz.	.txz
.tar.lz	Tarball compressed with lzip.	.tlz
.tar.Z	Tarball compressed with compress (older method).	
.tar.lzma	Tarball compressed with LZMA.

### Coding tips and tricks

## See also

* [xxxx](http://yyyyy)
