# frozen_string_literal: true

require_relative "lib/inscricao_estadual/version"

Gem::Specification.new do |spec|
  spec.name = "inscricao_estadual"
  spec.version = InscricaoEstadual::VERSION
  spec.authors = ["Thiago Chirana"]
  spec.email = ["engsw.thiago@gmail.com"]

  spec.summary = "Validador e gerador de Inscrição Estadual (IE) para empresas brasileiras por estado."
  spec.description = <<~DESC
    A gem `inscricao_estadual` fornece ferramentas para **gerar** e **validar** inscrições estaduais (IE)
    para empresas brasileiras, de acordo com as regras específicas de cada estado (UF).

    Ideal para aplicações fiscais, ERPs e automações que exigem validação de IE em cadastros de CNPJ.

    Recursos:
    - Validação de IE por estado com regras específicas
    - Geração de IE válidas para testes
    - Interface simples e extensível
    - Suporte inicial a alguns estados (ex: GO)

    Foco principal: validar corretamente a IE conforme os dígitos verificadores e formatos usados nas SEFAZ estaduais.
  DESC

  spec.homepage = "https://github.com/thiagochirana/inscricao_estadual"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/thiagochirana/inscricao_estadual"
  spec.metadata["changelog_uri"] = "https://github.com/thiagochirana/inscricao_estadual/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
