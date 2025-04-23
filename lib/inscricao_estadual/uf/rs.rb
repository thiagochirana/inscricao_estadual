module InscricaoEstadual
  module RS
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 10

      base = code[0..8].chars.map(&:to_i)
      dv_real = code[-1].to_i
      pesos = [2, 9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv_calc = [0, 1].include?(resto) ? 0 : 11 - resto

      dv_calc == dv_real
    end

    def generate
      base = Array.new(9) { rand(0..9) }
      pesos = [2, 9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv = [0, 1].include?(resto) ? 0 : 11 - resto

      (base + [dv]).join
    end
  end
end
