class Kodit < Formula
    include Language::Python::Virtualenv
  
    desc "Kodit is an MCP server that indexes your private codebases"
    homepage "https://docs.helixml.tech/kodit/"
    url "https://pypi.org/packages/source/k/kodit/kodit-0.5.21.tar.gz"
    sha256 "83542c42788e6f9114f7c64763e2e86c5e515ee44482cdd53f3aed6bfca45f06"
    license "Apache-2.0"
  
    depends_on "python@3.13"
    depends_on "uv"
  
    def install
      ENV["VIRTUAL_ENV"] = libexec
      system "uv", "venv", libexec
      ENV.prepend_path "PATH", "#{libexec}/bin"
      system "uv", "pip", "install", buildpath
      system "uv", "pip", "install", *resource_files if resources.any?
      
      bin.install Dir[libexec/"bin/*"]
      bin.env_script_all_files(libexec/"bin", PYTHONPATH: ENV["PYTHONPATH"])
    end
  
    test do
      assert_match "Usage: kodit [OPTIONS] COMMAND [ARGS]...", shell_output("#{bin}/kodit --help")
    end
  end
  