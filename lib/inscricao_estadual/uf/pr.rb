module InscricaoEstadual
  module PR
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 10

      base = code[0..7].chars.map(&:to_i)
      dv1_real = code[8].to_i
      dv2_real = code[9].to_i

      dv1_calc = calcula_dv1(base)
      return false unless dv1_calc == dv1_real

      dv2_calc = calcula_dv2(base + [dv1_calc])
      dv2_calc == dv2_real
    end

    def generate
      base = Array.new(8) { rand(0..9) }

      dv1 = calcula_dv1(base)
      dv2 = calcula_dv2(base + [dv1])

      (base + [dv1, dv2]).join
    end

    private

    def calcula_dv1(digits)
      pesos = [3, 2, 7, 6, 5, 4, 3, 2] # direita → esquerda
      soma = digits.reverse.each_with_index.sum { |n, i| n * pesos[i] }
      dv = 11 - (soma % 11)
      dv >= 10 ? 0 : dv
    end

    def calcula_dv2(digits)
      pesos = [4, 3, 2, 7, 6, 5, 4, 3, 2]
      soma = digits.reverse.each_with_index.sum { |n, i| n * pesos[i] }
      dv = 11 - (soma % 11)
      dv >= 10 ? 0 : dv
    end
  end
end
