sh install_sys.sh
sh install_OM.sh
export CC=/opt/openmpi-2.0.2/bin/mpicc
export CXX=/opt/openmpi-2.0.2/bin/mpicxx
export CF=/opt/openmpi-2.0.2/bin/mpif90
export FC=/opt/openmpi-2.0.2/bin/mpif90
export F77=/opt/openmpi-2.0.2/bin/mpif77
export LIBRARY_PATH=/opt/openmpi-2.0.2/lib/:${LIBRARY_PATH}
export PATH=/opt/openmpi-2.0.2/bin/:$PATH
sh install_boost.sh
sh install_HDF5.sh
sh install_netcdf.sh
sh install_tri.sh
sh install_peridigm.sh
