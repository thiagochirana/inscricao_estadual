# frozen_string_literal: true

require_relative "inscricao_estadual/version"
require_relative "inscricao_estadual/base"

Dir[File.join(__dir__, "inscricao_estadual/uf/*.rb")].sort.each { |f| require f }

module InscricaoEstadual
  def self.validate(code, uf:)
    klass = resolve_uf(uf)
    klass.validate(code)
  end

  def self.generate(uf:)
    klass = resolve_uf(uf)
    klass.generate
  end

  def self.resolve_uf(uf)
    const_get(uf.to_s.upcase)
  rescue NameError
    raise ArgumentError, "Estado '#{uf}' não suportado"
  end
end
