class Mld2p4 < Formula
  desc "MultiLevel Domain Decomposition Parallel Preconditioners using PSBLAS"
  homepage "https://github.com/sfilippone/mld2p4-2"
  # tag "math"

  url "https://github.com/sfilippone/mld2p4-2/archive/v2.1.0.tar.gz"
  sha256 "dff92d9acc3108b92a2573a238bf2f294f4ae936cfb071bd6683eea7ca8c0600"

  head "https://github.com/sfilippone/mld2p4-2.git"

  option "with-test", "Run build-time tests"

  depends_on :fortran
  depends_on :mpi => [:cc, :f90, :recommended]
  depends_on "psblas"
  depends_on "openblas" => OS.mac? ? :optional : :recommended
  depends_on "veclibfort" if build.without?("openblas") && OS.mac?
  depends_on "superlu" => :recommended
  depends_on "superlu_dist" => :recommended
  depends_on "mumps" => :recommended

  def install
    args = [
      "--disable-dependency-tracking",
      "--prefix=#{prefix}",
      "--with-psblas=#{Formula["psblas"].prefix}",
    ]
    if build.with? "openblas"
      args += ["--with-libs=-L#{Formula["openblas"].opt_lib}",
               "--with-blas=-lopenblas",
               "--with-lapack=-lopenblas"]
    elsif OS.mac?
      args += ["--with-libs=-L#{Formula["veclibfort"].opt_lib}",
               "--with-blas=-lvecLibFort",
               "--with-lapack=-lvecLibFort"]
    else
      args += ["--with-blas=-lblas", "--with-lapack=-llapack"]
    end
    args << "--enable-serial" if build.without? "mpi"
    args << "--with-superludir=#{Formula["superlu"].prefix}" if build.with? "superlu"
    args << "--with-superludistdir=#{Formula["superlu_dist"].prefix}" if build.with? "superlu_dist"
    args << "--with-mumpsdir=#{Formula["mumps"].prefix}" if build.with? "mumps"
    system "./configure", *args
    system "make", "install"
    system "make", "check" if build.with? "test"
  end

  test do
    ENV.fc
  end
end