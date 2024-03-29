#
# Created by gmakemake (Ubuntu Jul 25 2014) on Sat Nov 10 14:41:01 2018
#

#
# Definitions
#

.SUFFIXES:
.SUFFIXES:	.a .o .c .C .cpp .s .S
.c.o:
		$(COMPILE.c) $<
.C.o:
		$(COMPILE.cc) $<
.cpp.o:
		$(COMPILE.cc) $<
.S.s:
		$(CPP) -o $*.s $<
.s.o:
		$(COMPILE.cc) $<
.c.a:
		$(COMPILE.c) -o $% $<
		$(AR) $(ARFLAGS) $@ $%
		$(RM) $%
.C.a:
		$(COMPILE.cc) -o $% $<
		$(AR) $(ARFLAGS) $@ $%
		$(RM) $%
.cpp.a:
		$(COMPILE.cc) -o $% $<
		$(AR) $(ARFLAGS) $@ $%
		$(RM) $%

CC =		gcc
CXX =		g++

RM = rm -f
AR = ar
LINK.c = $(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)
LINK.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS)
COMPILE.c = $(CC) $(CFLAGS) $(CPPFLAGS) -c
COMPILE.cc = $(CXX) $(CXXFLAGS) $(CPPFLAGS) -c
CPP = $(CPP) $(CPPFLAGS)
########## Flags from header.mak

# for programs using pthreads and curses
CXXFLAGS =	-ggdb
CFLAGS =	-ggdb -std=c99 -Wall -Wextra -pthread
# might use wide character data
CLIBFLAGS =	-lm -lncursesw -pthread

########## End of flags from header.mak


CPP_FILES =	
C_FILES =	thread.c threads.c
PS_FILES =	
S_FILES =	
H_FILES =	threads.h
SOURCEFILES =	$(H_FILES) $(CPP_FILES) $(C_FILES) $(S_FILES)
.PRECIOUS:	$(SOURCEFILES)
OBJFILES =	thread.o 

#
# Main targets
#

all:	threads 

threads:	threads.o $(OBJFILES)
	$(CC) $(CFLAGS) -o threads threads.o $(OBJFILES) $(CLIBFLAGS)

#
# Dependencies
#

thread.o:	threads.h
threads.o:	threads.h

#
# Housekeeping
#

Archive:	archive.tgz

archive.tgz:	$(SOURCEFILES) Makefile
	tar cf - $(SOURCEFILES) Makefile | gzip > archive.tgz

clean:
	-/bin/rm -f $(OBJFILES) threads.o core

realclean:        clean
	-/bin/rm -f threads 
