module InscricaoEstadual
  module RJ
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 8

      base = code[0..6].chars.map(&:to_i)
      dv_real = code[-1].to_i
      pesos = [2, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv_calc = resto <= 1 ? 0 : 11 - resto

      dv_calc == dv_real
    end

    def generate
      base = Array.new(7) { rand(0..9) }
      pesos = [2, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv = resto <= 1 ? 0 : 11 - resto

      (base + [dv]).join
    end
  end
end
