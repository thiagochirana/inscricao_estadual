module InscricaoEstadual
  module PE
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless [9, 14].include?(code.length)

      if code.length == 9
        validate_efisco(code)
      else
        validate_cacepe(code)
      end
    end

    def generate
      base = Array.new(7) { rand(0..9) }
      d1 = calcula_dv(base, [8, 7, 6, 5, 4, 3, 2])
      d2 = calcula_dv(base + [d1], [9, 8, 7, 6, 5, 4, 3, 2])
      (base + [d1, d2]).join
    end

    private

    def calcula_dv(numeros, pesos)
      soma = numeros.each_with_index.sum { |n, i| n * pesos[i] }
      resto = soma % 11
      resto <= 1 ? 0 : 11 - resto
    end

    def validate_efisco(code)
      base = code[0..6].chars.map(&:to_i)
      d1_real = code[7].to_i
      d2_real = code[8].to_i

      d1_calc = calcula_dv(base, [8, 7, 6, 5, 4, 3, 2])
      d2_calc = calcula_dv(base + [d1_calc], [9, 8, 7, 6, 5, 4, 3, 2])

      d1_calc == d1_real && d2_calc == d2_real
    end

    def validate_cacepe(code)
      digits = code.chars.map(&:to_i)
      return false unless digits.size == 14

      pesos = [5, 4, 3, 2, 1, 9, 8, 7, 6, 5, 4, 3, 2]
      soma = digits[0..12].each_with_index.sum { |n, i| n * pesos[i] }
      dv = 11 - (soma % 11)
      dv -= 10 if dv > 9

      dv == digits[13]
    end
  end
end
