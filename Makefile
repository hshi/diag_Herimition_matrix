PROG    := diag

#On my local computer
CC      := mpic++ -DMPI_HAO -DUSE_MKL
FLAGS   := -Wall -O3 -std=c++11
HAOFLG  := -I/home/boruoshihao/lib_hao/mpi/include
HAOLIB  := -L/home/boruoshihao/lib_hao/mpi/lib -lmatrixhao
MFLG    := -DMKL_ILP64 -fopenmp -m64 -I/opt/intel/mkl/include
MLIB    := -Wl,--no-as-needed -L/opt/intel/mkl/lib/intel64 -lmkl_intel_ilp64 -lmkl_core -lmkl_gnu_thread  -ldl -lpthread -lm

#On Hurricane or Storm
#CC      := mpicxx -DMPI_HAO -DUSE_ACML
#FLAGS   := -Wall -O3 -march=corei7 -m64 -std=c++11  #Hurricane
#FLAGS   := -Wall -O3 -march=barcelona -std=c++11    #Storm
#HAOFLG  := -I/sciclone/home00/hshi/lib_hao/library/mpi/include
#HAOLIB  := -L/sciclone/home00/hshi/lib_hao/library/mpi/lib -lmatrixhao
#MFLG    :=
#MLIB    := -L${ACML}/lib -lacml


FLAGSALL:= $(FLAGS) $(HAOFLG) $(MFLG) 
LIBSALL :=          $(HAOLIB) $(MLIB)

SRCS      := $(wildcard *.cpp)
SRCOBJS   := ${SRCS:.cpp=.o}

.PHONY: all clean

all: $(PROG)


$(PROG): $(SRCOBJS)
	$(CC) $(FLAGSALL) -o $(PROG) $(SRCOBJS) $(LIBSALL)

rmdat:
	rm -f *.dat

clean:
	rm -rf $(PROG)
	rm -rf $(SRCOBJS)
	rm -f *.o  *.mod *.out *.dat *~

%.o :%.cpp
	$(CC) $(FLAGSALL) -c -o $@ $<


#define OBJECT_DEPENDS_ON_CORRESPONDING_HEADER
#    $(1) : ${1:.o=.h}
#endef
#
#$(foreach object_file,$(SRCOBJS),$(eval $(call OBJECT_DEPENDS_ON_CORRESPONDING_HEADER,$(object_file)))) 
