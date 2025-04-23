module InscricaoEstadual
  module MA
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 9
      return false unless code.start_with?("12")

      base = code[0..7].chars.map(&:to_i)
      dv = code[-1].to_i
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      calculado = resto <= 1 ? 0 : 11 - resto

      calculado == dv
    end

    def generate
      base = [1, 2] + Array.new(6) { rand(0..9) } # prefixo + 6 dígitos
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv = resto <= 1 ? 0 : 11 - resto

      (base + [dv]).join
    end
  end
end
