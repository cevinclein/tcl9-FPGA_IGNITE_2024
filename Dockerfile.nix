FROM efabless/openlane:latest

RUN nix-env -iA nixpkgs.gnumake 
RUN nix-env -iA nixpkgs.gcc
RUN nix-env -iA nixpkgs.minizip
RUN nix-env -iA nixpkgs.gawk
RUN nix-env -iA nixpkgs.zlib
RUN nix-env -iA nixpkgs.zlib-ng


WORKDIR /
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

ENV PATH=/tcl9.0.0/unix:$PATH

WORKDIR /

RUN git clone https://github.com/tcltk/tcllib.git

RUN yes | tclsh /tcllib/installer.tcl

RUN nix-env -iA nixpkgs.python312Packages.pip

RUN pip install --break-system-packages click PyYAML
