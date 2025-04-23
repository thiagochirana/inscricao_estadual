# frozen_string_literal: true

module InscricaoEstadual
  module GO
    module_function

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 9

      prefix = code[0..1].to_i
      return false unless [10, 11].include?(prefix) || (20..29).include?(prefix)

      body = code[0..7].chars.map(&:to_i)
      dv = code[-1].to_i
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = body.each_with_index.sum { |num, i| num * pesos[i] }
      resto = soma % 11

      verificador = if [0, 1].include?(resto)
                      0
                    else
                      11 - resto
                    end

      verificador == dv
    end

    def generate(prefix = 10)
      raise ArgumentError, "Prefixo inválido" unless [10, 11].include?(prefix) || (20..29).include?(prefix)

      body = [*prefix.to_s.rjust(2, "0").chars.map(&:to_i)] + Array.new(6) { rand(0..9) }
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = body.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11

      dv = [0, 1].include?(resto) ? 0 : 11 - resto

      (body.join + dv.to_s)
    end
  end
end
