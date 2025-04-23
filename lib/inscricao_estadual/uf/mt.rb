module InscricaoEstadual
  module MT
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 11

      base = code[0..9].chars.map(&:to_i)
      dv = code[-1].to_i
      pesos = [3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      calculado = [0, 1].include?(resto) ? 0 : 11 - resto

      calculado == dv
    end

    def generate
      base = Array.new(10) { rand(0..9) }
      pesos = [3, 2, 9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      dv = [0, 1].include?(resto) ? 0 : 11 - resto

      (base + [dv]).join
    end
  end
end
