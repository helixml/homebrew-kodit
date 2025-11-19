class Kodit < Formula
    include Language::Python::Virtualenv
  
    desc "Kodit is an MCP server that indexes your private codebases"
    homepage "https://docs.helixml.tech/kodit/"
    url "https://pypi.org/packages/source/k/kodit/kodit-0.5.13.tar.gz"
    sha256 "a4c62fe09042b9c38ad886e5b3bfab3f8a6c0befbbc3f3fc49531fe8510f7c6e"
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
  