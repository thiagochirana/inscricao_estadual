module InscricaoEstadual
  module SE
    extend self

    def validate(code)
      code = code.to_s.gsub(/\D/, "")
      return false unless code.length == 9

      base = code[0..7].chars.map(&:to_i)
      dv_real = code[-1].to_i
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |digit, i| digit * pesos[i] }
      resto = soma % 11
      dv_calc = 11 - resto
      dv_calc = 0 if dv_calc >= 10

      dv_calc == dv_real
    end

    def generate
      base = Array.new(8) { rand(0..9) }
      pesos = [9, 8, 7, 6, 5, 4, 3, 2]

      soma = base.each_with_index.sum { |digit, i| digit * pesos[i] }
      resto = soma % 11
      dv = 11 - resto
      dv = 0 if dv >= 10

      (base + [dv]).join
    end
  end
end
