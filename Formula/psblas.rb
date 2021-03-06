class Psblas < Formula
  desc "Framework for easy, efficient and portable iterative solvers"
  homepage "https://github.com/sfilippone/psblas3"
  # doi "10.1145/365723.365732", "10.1016/j.apnum.2007.01.006", "10.1007/11558958_71", "10.1007/978-3-642-29737-3_41", "10.1007/s00200-007-0035-z", "10.1145/1824801.1824808"
  # tag "math"

  url "https://github.com/sfilippone/psblas3/archive/v3.5.0-3.tar.gz"
  sha256 "4da1afceeefadb7b50f0e62799efce7ef317147d11792d9eaf4d60d4ac676894"

  head "https://github.com/sfilippone/psblas3.git"

  option "without-test", "Skip build-time tests (not recommended)"
  option "with-long-ints", "Build with 64 bit integers for > 2GB index space"

  depends_on "gcc"
  depends_on "mpich" => :recommended
  depends_on "openblas" => OS.mac? ? :optional : :recommended
  depends_on "veclibfort" if build.without?("openblas") && OS.mac?
  depends_on "metis" => :optional

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
    args << "--enable-serial" if build.without? "mpich"
    args << "--enable-long-integers" if build.with? "long-ints"
    system "./configure", *args
    system "make", "install"
    # system "make", "check" if build.with? "test" # remove until Salvatore can fix for real
  end

  test do
    ENV.fc
  end
end
