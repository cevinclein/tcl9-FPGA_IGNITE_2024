FROM efabless/openlane:2023.07.19-1

# -----------------------------------------

WORKDIR /

ENV MINICONDA_VERSION=latest
ENV MINICONDA_INSTALL_DIR=/opt/miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-${MINICONDA_VERSION}-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p ${MINICONDA_INSTALL_DIR} && \
    rm /tmp/miniconda.sh

# Add Miniconda to PATH
ENV PATH="${MINICONDA_INSTALL_DIR}/bin:${PATH}"

# Add Miniconda to PATH
ENV PATH="${MINICONDA_INSTALL_DIR}/bin:${PATH}"

# Create a Conda environment and install GCC
RUN conda install conda-forge::gcc

RUN conda init && source ~/.bashrc && conda activate

RUN git clone https://github.com/madler/zlib.git
WORKDIR /zlib
RUN ./configure
RUN make && make install

WORKDIR /zlib/contrib/minizip
RUN make

WORKDIR /

RUN wget http://prdownloads.sourceforge.net/tcl/tcl9.0.0-src.tar.gz
RUN tar -xvzf tcl9.0.0-src.tar.gz

WORKDIR /tcl9.0.0/unix

RUN ./configure --enable-64bit

RUN mkdir -p /tcl9.0.0/unix/pkgs8/thread3.0.0/
RUN ln -s /zlib/contrib/minizip/minizip /tcl9.0.0/unix/pkgs8/thread3.0.0/minizip
RUN mkdir -p /tcl9.0.0/unix/pkgs/thread3.0.0/
RUN ln -s /zlib/contrib/minizip/minizip /tcl9.0.0/unix/pkgs/thread3.0.0/minizip

RUN rm /zlib/Makefile /zlib/Makefile.in /zlib/configure
RUN cp -r /zlib/* /tcl9.0.0/unix

RUN make
RUN make install

RUN conda init && source ~/.bashrc && conda deactivate && source ~/.bashrc
RUN conda config --set auto_activate_base false

ENV PATH=/tcl9.0.0/unix:$PATH

WORKDIR /

RUN git clone https://github.com/tcltk/tcllib.git

RUN source ~/.bashrc 

WORKDIR /

RUN yes | tclsh /tcllib/installer.tcl

RUN pip install click PyYAML

COPY /fcpys/emitter.py /openlane/dependencies/includedyaml/emitter.py
COPY /fcpys/tool.py /openlane/dependencies/tool.py
