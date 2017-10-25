class Psblas < Formula
  desc "Framework for easy, efficient and portable iterative solvers"
  homepage "https://github.com/sfilippone/psblas3"
  # doi "10.1145/365723.365732", "10.1016/j.apnum.2007.01.006", "10.1007/11558958_71", "10.1007/978-3-642-29737-3_41", "10.1007/s00200-007-0035-z", "10.1145/1824801.1824808"
  # tag "math"

  url "https://github.com/sfilippone/psblas3/archive/v3.5.0.tar.gz"
  sha256 "2c110c5382e4ba344c92e193e13432e860b278f240b4d3657b7b2c21b8e3f64a"

  option "with-test", "Run build-time tests"

  depends_on :fortran
  depends_on :mpi => [:cc, :f90, :recommended]
  depends_on "openblas" => OS.mac? ? :optional : :recommended
  depends_on "veclibfort" if build.without?("openblas") && OS.mac?
  depends_on "metis" => :recommended

  def install
    args = ["--disable-dependency-tracking", "--prefix=#{prefix}"]
    args << "--with-metisdir=#{Formula["metis"].opt_prefix}" if build.with? "metis"
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
    system "./configure", *args
    system "make", "install"
    system "make", "check" if build.with? "test"
  end

  test do
    ENV.fc
  end
end
